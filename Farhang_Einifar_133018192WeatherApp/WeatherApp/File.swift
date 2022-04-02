//
//  File.swift
//  WeatherApp
//
//  Created by Farhang on 03/22/22.
//

import Foundation
class DataModel {
    var array:[Weather] = []
    
    func addition(obj:Weather) {
        self.array.append(obj)
    }
    
    func saveReport(temp:Double, windSpeed: Double, windDirection: String, city: String) {
        let time = calculateCurrentTime()
        let weatherObj = Weather(city: city, time: time, windSpeed: windSpeed, direction: windDirection, temprature: temp)
        self.addition(obj: weatherObj)
    }
    
    func getArray() -> [Weather] {
        return array
    }
    
    func calculateCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: Date())
        return dateString
    }
}
