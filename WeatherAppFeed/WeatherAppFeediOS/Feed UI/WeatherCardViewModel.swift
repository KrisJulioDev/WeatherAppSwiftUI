//
//  WeatherCardViewModel.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/19/24.
//

import SwiftUI
import WeatherAppFeed
 
struct WeatherInfo {
    let title: String
    let value: String?
    let image: Image
}

struct WeatherCardViewModel {
    private let item: WeatherItem
    
    public init(item: WeatherItem) {
        self.item = item
    }
    
    var name: String {
        item.name + ", " + item.country
    }
    
    var weatherDescription: String? {
        item.weatherDescription?.capitalized
    }
    
    var weatherIcon: URL? {
        URL(string: "https://openweathermap.org/img/w/\(item.weatherIcon ?? "").png")
    }
    
    var currentTimeTitle: String {
        NSLocalizedString("CURRENT_TIME",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "current time title")
    }
    
    var todaysForecastTitle: String {
        NSLocalizedString("TODAYS_FORECAST",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "todaysForecast title")
    }
    
    var currentTime: String {
        let timestamp = TimeInterval(item.dt)
        let date = Date(timeIntervalSince1970: timestamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss aa"

        return dateFormatter.string(from: date)
    }
    
    var weatherInfo: [WeatherInfo] {
        [
            WeatherInfo(title: "Feels",
                        value: GlobalFormatter.temperature(from: item.feelsLike),
                        image: Image(systemName: "thermometer.medium")),
            
            WeatherInfo(title: "Humid",
                        value: GlobalFormatter.humidity(from: item.humidity),
                        image: Image(systemName: "humidity.fill")),
            
            WeatherInfo(title: "Wind",
                        value: GlobalFormatter.windSpeed(from: item.windSpeed),
                        image: Image(systemName: "wind")),
            
            WeatherInfo(title: "Clouds",
                        value: String(item.clouds) + "%",
                        image: Image(systemName: "cloud")),
        ]
        .filter { $0.value != nil }
    }
    
}

struct GlobalFormatter {
    static func temperature(from value: Double) -> String {
        let formatter = MeasurementFormatter()
        let temperature = Measurement<UnitTemperature>(value: value, unit: .kelvin)
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: temperature)
    }
    
    static func windSpeed(from value: Double) -> String {
        let formatter = MeasurementFormatter()
        let speed = Measurement<UnitSpeed>(value: value, unit: .kilometersPerHour)
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: speed)
    }
    
    static func humidity(from value: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: value * 0.01))
    }
}
