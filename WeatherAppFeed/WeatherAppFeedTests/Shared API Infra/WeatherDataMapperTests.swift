//
//  WeatherDataMapperTests.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//

import XCTest
import WeatherAppFeed

final class WeatherDataMapperTests: XCTestCase {
 
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([:])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try WeatherItemMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try WeatherItemMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
 
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let item = makeValidItem()
        let data = makeItemsJSON(item.json)
        let response = HTTPURLResponse(statusCode: 200)
        
        let result = try WeatherItemMapper.map(data, from: response)
        
        XCTAssertEqual(result, item.model)
    }
    
    // MARK: Helper
    
    private func makeItemsJSON(_ items: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
    private func makeValidItem() -> (model: WeatherItem, json: [String: Any]) {
        let item = WeatherItem(id: 2643743, name: "London", temp: 271.79, feelsLike: 271.79, tempMin: 270.21, tempMax: 273.13, pressure: 1000, humidity: 84, visibility: 10000, windSpeed: 0.89, dt: 1705450380, clouds: 83, timezone: 0)
        
        let json = weatherJSON()
        
        return (item, json)
    }
    
    private func weatherJSON() -> [String: Any] {
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
}
