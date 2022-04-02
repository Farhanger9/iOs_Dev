//
//  WeatherHistoryViewController.swift
//  WeatherApp
//
//  Created by Farhang on 03/21/22.
//

import UIKit



class WeatherHistoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var array:[Weather] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let model = array[indexPath.row]
        cell.titleLbl.text = model.city +  " at " + model.time
        cell.subtitleLbl.text = "Wind: " +  String(model.windSpeed) + " kph from " + model.direction
        
        cell.tempLbl.text = String(model.temprature) + "℃"
                
                return cell

    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather History"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
