//
//  FeedEndpoint.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//
 
public enum FeedEndpoint {
    case getWeather(WeatherQuery)
    
    public func url(baseURL: URL, apiKey: String) -> URL {
        switch self {
        case let .getWeather(query):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/data/3.0/onecall"
            components.queryItems = [
                URLQueryItem(name: "lat", value: query.latitude),
                URLQueryItem(name: "lon", value: query.longitude),
                URLQueryItem(name: "appid", value: apiKey), 
                URLQueryItem(name: "units", value: query.unitParameter)
            ].compactMap { $0 }
            
            if let intervals = query.intervals {
                components.query?.append(intervals)
            }
            
            return components.url!
        }
    }
}
