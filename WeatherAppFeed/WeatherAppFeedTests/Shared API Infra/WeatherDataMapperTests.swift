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
        
        XCTAssertEqual(result.id, item.model.id)
        XCTAssertEqual(result.name, item.model.name)
        XCTAssertEqual(result.temp, item.model.temp)
        XCTAssertEqual(result.feelsLike, item.model.feelsLike)
        XCTAssertEqual(result.pressure, item.model.pressure)
        XCTAssertEqual(result.humidity, item.model.humidity)
        XCTAssertEqual(result.visibility, item.model.visibility)
        XCTAssertEqual(result.windSpeed, item.model.windSpeed)
        XCTAssertEqual(result.dt, item.model.dt)
        XCTAssertEqual(result.clouds, item.model.clouds)
    }
    
    // MARK: Helper
    
    private func makeItemsJSON(_ items: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
}
