//
//  WeatherItem.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation 

public struct WeatherItem: Equatable {
    let id: Int
    let name: String
    
    // Main data
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    let visibility: Int
    let windSpeed: Double
    
    let dt: Int
    let clouds: Int
    let timezone: Int
    
    public init(id: Int, name: String, temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, visibility: Int, windSpeed: Double, dt: Int, clouds: Int, timezone: Int) {
        self.id = id
        self.name = name
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.dt = dt
        self.clouds = clouds
        self.timezone = timezone
    }
}
