//
//  SharedTestHelpers.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//

import WeatherAppFeed

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyURLResponse() -> HTTPURLResponse {
    HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
}
   
func makeValidItem() -> (model: WeatherItem, json: [String: Any]) {
   let item = WeatherItem(id: 2643743, name: "London", country: "US", weatherDescription: "descriptio", weatherIcon: "icon" ,temp: 271.79, feelsLike: 271.79, pressure: 1000, humidity: 84, visibility: 10000, windSpeed: 0.89, rain: 0.85, dt: 1705450380, clouds: 83)
   
   let json = weatherJSON()
   
   return (item, json)
}

func weatherJSON() -> [String: Any] {
    return [
        "coord": [
                "lon": -0.1257,
                "lat": 51.5085
            ],
            "weather": [
                [
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04n"
                ]
            ],
            "base": "stations",
            "main": [
                "temp": 271.79,
                "feels_like": 271.79,
                "temp_min": 270.21,
                "temp_max": 273.13,
                "pressure": 1000,
                "humidity": 84
            ],
            "visibility": 10000,
            "wind": [
                "speed": 0.89,
                "deg": 244,
                "gust": 1.34
            ],
            "clouds": [
                "all": 83
            ],
        "rain": [
            "lh": 0.85
        ],
            "dt": 1705450380,
            "sys": [
                "type": 2,
                "id": 2091269,
                "country": "GB",
                "sunrise": 1705478291,
                "sunset": 1705508528
            ],
            "timezone": 0,
            "id": 2643743,
            "name": "London",
            "cod": 200
    ]
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
