//
//  WeatherQuery.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

public enum UpdateInterval: String, Codable {
    case current, minutely, hourly, daily, alerts
}

public enum Unit: String, Codable {
    case standard, metric, imperial
}

public struct WeatherQuery: Codable {
    let latitude: String
    let longitude: String
    private let interval: [UpdateInterval]
    private let unit: Unit
    
    public init(latitude: String,
         longitude: String,
         interval: [UpdateInterval] = [],
         unit: Unit = .standard) {
        self.latitude = latitude
        self.longitude = longitude
        self.interval = interval
        self.unit = unit
    }
    
    var intervals: String? {
        return interval.isEmpty ? nil : interval.map { $0.rawValue }.joined(separator: ",")
    }
    
    var unitParameter: String {
        unit.rawValue
    }
}
