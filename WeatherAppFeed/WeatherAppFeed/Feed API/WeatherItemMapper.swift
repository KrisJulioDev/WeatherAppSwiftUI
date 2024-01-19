//
//  WeatherItemMapper.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation

public final class WeatherItemMapper {
    
    struct RootData: Codable {
        private let coord: Coordinates
        private let weather: [Weather]
        private let base: String
        private let main: Main
        private let visibility: Double
        private let wind: Wind
        private let clouds: Clouds
        private let dt: Int
        private let rain: Rain?
        private let sys: Sys
        private let timezone: Int
        private let id: Int
        private let name: String
        private let cod: Int
        
        var weatherItem: WeatherItem {
            WeatherItem(id: id, name: name, country: sys.country, 
                        weatherDescription: weather.first?.description, weatherIcon: weather.first?.icon,
                        temp: main.temp, feelsLike: main.feels_like, pressure: main.pressure, humidity: main.humidity, visibility:visibility , windSpeed: wind.speed, rain: rain?.lh, dt: dt, clouds: clouds.all)
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case invalidAPIKey
        case notFound(String)
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> WeatherItem {
        guard response.isOK, let root = try? JSONDecoder().decode(RootData.self, from: data) else {
            throw errorFor(response)
        }
        
        return root.weatherItem
    }
    
    private static func errorFor(_ response: HTTPURLResponse) -> Error {
        switch response.statusCode {
        case 401:
            return .invalidAPIKey
        case 404:
            return .notFound(response.description)
        default:
            return .invalidData
        }
    }
}

extension WeatherItemMapper {
    private struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }

    private struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    private struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Double
    }

    private struct Wind: Codable {
        let speed: Double 
    }

    private struct Clouds: Codable {
        let all: Int
    }
 
    private struct Rain: Codable {
        let lh: Double?
    }

    private struct Sys: Codable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Int?
        let sunset: Int?
    }

}
