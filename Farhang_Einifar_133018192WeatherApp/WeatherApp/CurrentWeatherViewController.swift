//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Farhang on 03/21/22.
//

import UIKit
import MapKit
import CoreLocation

class CurrentWeatherViewController: UIViewController , CLLocationManagerDelegate {
    var locationManager :CLLocationManager!
    var city = ""
    var windSpeed = 0.0
    var temp = 0.0
    var windDir = ""
    var data = DataModel()
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var wind: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Weather"
        self.cityLabel.text = ""
        self.temperature.text = ""
        self.wind.text = ""
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                        if error != nil {
                            return
                        }else if let country = placemarks?.first?.country,
                            let city = placemarks?.first?.locality {
                            print(country)
                            self.city = city
                        }
                        else {
                        }
                    })
        fetchWeatherAPICall(city: self.city)
    }
    
    
    func fetchWeatherAPICall(city:String){
        let urlString  = "https://api.weatherapi.com/v1/current.json?key=8e4e2e88ffab40c1957180715222103&q=\(city)&aqi=no"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let current = json["current"] as? [String: Any]{
                    self.windSpeed = current["wind_kph"] as? Double ?? 0.0
                    self.temp = current["temp_c"] as? Double ?? 0.0
                    self.windDir = current["wind_dir"] as? String ?? ""
                    
                    // main thread
                    DispatchQueue.main.async {
                        self.cityLabel.text = city
                        self.temperature.text = String(self.temp) + "℃"
                        self.wind.text = "\(String(self.windSpeed)) kph from \(String(describing: self.windDir))";
                        
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        
        //wind_kph
        //temp_c
        //wind_dir
    

        task.resume()
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        data.saveReport(temp: self.temp, windSpeed: self.windSpeed, windDirection: self.windDir, city: self.city)
        
        let alert = UIAlertController(title: "", message: "Data Saved", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func seeHistoryBtnTap(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherHistoryViewController") as? WeatherHistoryViewController
        vc?.array = data.getArray()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
