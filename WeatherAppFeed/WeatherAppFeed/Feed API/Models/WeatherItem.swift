//
//  WeatherItem.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation 

public struct WeatherItem: Hashable {
    
    public let id: Int
    public let name: String
    public let country: String
    public let weatherDescription: String?
    public let weatherIcon: String?
    public let temp: Double
    public let feelsLike: Double
    public let pressure: Double
    public let humidity: Double
    public let visibility: Double
    public let windSpeed: Double
    public let rain: Double?
    public let dt: Int
    public let clouds: Int
    
    public init(id: Int, name: String, country: String, 
                weatherDescription: String?, weatherIcon: String?,
                temp: Double, feelsLike: Double, pressure: Double, humidity: Double, visibility: Double, windSpeed: Double, rain: Double?, dt: Int, clouds: Int) {
        self.id = id
        self.name = name
        self.country = country
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.rain = rain
        self.dt = dt
        self.clouds = clouds
    }
    
    static public func ==(lhs: WeatherItem, rhs: WeatherItem) -> Bool {
        return lhs.id == rhs.id
    }
}
