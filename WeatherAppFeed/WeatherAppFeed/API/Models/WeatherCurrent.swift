//
//  WeatherCurrent.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation

public struct Current: Decodable {
    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let temp: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherInfo]
    
    public init(dt: TimeInterval, sunrise: TimeInterval, sunset: TimeInterval, temp: Double, feelsLike: Double, pressure: Double, humidity: Int, dewPoint: Double, uvi: Double, clouds: Int, visibility: Int, windSpeed: Double, windDeg: Int, windGust: Double, weather: [WeatherInfo]) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.dewPoint = dewPoint
        self.uvi = uvi
        self.clouds = clouds
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.windGust = windGust
        self.weather = weather
    }
}
 
public struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    public init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
