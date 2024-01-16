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
        let item = WeatherItem(lat: 90, lon: 90, timezone: "America/Chicago", timezoneOffset: -18000, current: Current(dt: 1684926645, sunrise: 1684926645, sunset: 1684926645, temp: 292.55, feelsLike: 292.55, pressure: 1014, humidity: 15, dewPoint: 22, uvi: 11, clouds: 1014, visibility: 12, windSpeed: 123, windDeg: 1231, windGust: 2131, weather: [WeatherInfo(id: 90, main: "main", description: "descr", icon: "icon")]))
        
        let json = weatherJSON()
        
        return (item, json)
    }
    
    private func weatherJSON() -> [String: Any] {
        return [
            "lat": 90,
            "lon": 90,
            "timezone": "America/Chicago",
            "timezoneOffset": -18000,
            "current": [
                "dt": 1684926645,
                "sunrise": 1684926645,
                "sunset": 1684926645,
                "temp": 292.55,
                "feelsLike": 292.55,
                "pressure": 1014,
                "humidity": 15,
                "dewPoint": 22,
                "uvi": 11,
                "clouds": 1014,
                "visibility": 12,
                "windSpeed": 123,
                "windDeg": 1231,
                "windGust": 2131,
                "weather": [
                    [
                        "id": 90,
                        "main": "main",
                        "description": "descr",
                        "icon": "icon"
                    ]
                ]
            ]
        ]
    }
}
