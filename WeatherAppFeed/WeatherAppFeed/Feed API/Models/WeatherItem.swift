//
//  WeatherItem.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation 

public struct WeatherItem: Equatable {
    public let id: Int
    public let name: String
    public let country: String
    public let weatherDescription: String?
    public let weatherIcon: String?
     
    public  let temp: Double
    public  let feelsLike: Double
    public  let tempMin: Double
    public  let tempMax: Double
    public  let pressure: Int
    public  let humidity: Int

    public  let visibility: Int
    public  let windSpeed: Double

    public let rain: Double?
    
    public  let dt: Int
    public  let clouds: Int
    public  let timezone: Int
    
    public init(id: Int, name: String, country: String, 
                weatherDescription: String?, weatherIcon: String?,
                temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, visibility: Int, windSpeed: Double, rain: Double?, dt: Int, clouds: Int, timezone: Int) {
        self.id = id
        self.name = name
        self.country = country
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.rain = rain
        self.dt = dt
        self.clouds = clouds
        self.timezone = timezone
    }
}
