//
//  WeatherItem.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation

public struct WeatherItem: Hashable {
    let id: String
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    
    public init(lat: Double, lon: Double, timezone: String, timezoneOffset: Int, current: Current) {
        self.id = "\(lat)\(lon)"
        self.lat = lat
        self.lon = lon
        self.timezone = timezone
        self.timezoneOffset = timezoneOffset
        self.current = current
    }
    
    public static func == (lhs: WeatherItem, rhs: WeatherItem) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
