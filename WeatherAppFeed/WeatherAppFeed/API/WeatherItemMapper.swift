//
//  WeatherItemMapper.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation

public final class WeatherItemMapper {
    private struct RootItem: Decodable {
        let lat: Double
        let lon: Double
        let timezone: String
        let timezoneOffset: Int
        let current: Current
         
        var weatherItem: WeatherItem {
            WeatherItem(lat: lat, lon: lon, timezone: timezone , timezoneOffset: timezoneOffset, current: current)
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> WeatherItem {
        guard response.isOK, let root = try? JSONDecoder().decode(RootItem.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.weatherItem
    }
}
