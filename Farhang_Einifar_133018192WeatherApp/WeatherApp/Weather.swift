//
//  Weather.swift
//  WeatherApp
//
//  Created by Farhang on 03/21/22.
//

import Foundation
class Weather {
    
    var city: String;
    var time: String;
    var windSpeed: Double;
    var direction: String;
    var temprature: Double
    
    init(city:String, time:String, windSpeed:Double, direction:String, temprature:Double){
        self.city = city
        self.time = time
        self.windSpeed = windSpeed
        self.direction = direction
        self.temprature = temprature
    }
    
    
    
}
