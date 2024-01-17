//
//  FeedEndpoint.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//
 
public enum FeedEndpoint {
    case getWeather(String)
    
    public func url(baseURL: URL, apiKey: String) -> URL {
        switch self {
        case let .getWeather(location):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/data/2.5/weather"
            components.queryItems = [
                URLQueryItem(name: "q", value: location),
                URLQueryItem(name: "appid", value: apiKey)
            ]
             
            return components.url!
        }
    }
}
