//
//  WeatherAppFeedEndToEndTests.swift
//  WeatherAppFeedEndToEndTests
//
//  Created by Khristoffer Julio on 1/17/24.
//

import XCTest
import WeatherAppFeed

final class WeatherAppFeedEndToEndTests: XCTestCase {
        
    func test_endToEndTestServerGETWeatherResult_matchesFixedData() async throws {
        let data: [(Int, String)] = [
            (2643743, "London"),
            (1701668, "Manila"),
            (5855797, "Hawaii")
        ]
        
        for (id, name) in data {
            let (data, response) = try await getWeatherResult(location: name)
            let item = try WeatherItemMapper.map(data, from: response)
             
            XCTAssertEqual(item.id, id, "item id")
            XCTAssertEqual(item.name, name, "item name")
        }
    }
    
    // MARK: - Helpers
    
    private func getWeatherResult(location: String, file: StaticString = #file, line: UInt = #line) async throws -> HTTPClient.Result {
        let client = ephemeralClient()
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = ConfigManager.getAPIKEY()
  
        return try await client.get(from: FeedEndpoint.getWeather(location).url(baseURL: baseURL, apiKey: apiKey))
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> URLSessionHTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
}
