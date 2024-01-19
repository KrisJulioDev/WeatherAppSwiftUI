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
                        value: String(item.feelsLike),
                        image: Image(systemName: "thermometer.medium")),
            
            WeatherInfo(title: "Humid",
                        value: String(item.humidity) + "%",
                        image: Image(systemName: "humidity.fill")),
            
            WeatherInfo(title: "Rain",
                        value: item.rain == nil ? nil : String(item.rain!),
                        image: Image(systemName: "cloud.rain.fill")),
            
            WeatherInfo(title: "Wind",
                        value: String(item.windSpeed),
                        image: Image(systemName: "wind")),
            
            WeatherInfo(title: "Clouds",
                        value: String(item.clouds) + "%",
                        image: Image(systemName: "cloud")),
        ]
        .filter { $0.value != nil }
    }
     
}
