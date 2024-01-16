//
//  WeatherItemMapper.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation
 
public final class WeatherItemMapper {
    public struct WeatherItem: Decodable {
        let lat: Double
        let lon: Double
        let timezone: String
        let timezoneOffset: Int
        let current: Current
    }
    
    public struct Current: Decodable {
        let dt: TimeInterval
        let sunrise: TimeInterval
        let sunset: TimeInterval
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        
        public struct WeatherInfo: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        let weather: [WeatherInfo]
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> WeatherItem {
        guard response.isOK, let root = try? JSONDecoder().decode(WeatherItem.self, from: data) else {
            throw Error.invalidData
        }
        
        return root
    }
}
