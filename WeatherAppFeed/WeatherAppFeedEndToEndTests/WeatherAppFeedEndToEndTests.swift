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
        let (data, response) = try await getWeatherResult()
        let exp = expectation(description: "wait for request")
        let item = try WeatherItemMapper.map(data, from: response)
        exp.fulfill()
         
        await fulfillment(of: [exp])
         
        XCTAssertEqual(item.id, 2643743, "item id")
        XCTAssertEqual(item.name, "London", "item name")
    }
    
    // MARK: - Helpers
    
    private func getWeatherResult(file: StaticString = #file, line: UInt = #line) async throws -> HTTPClient.Result {
        let client = ephemeralClient()
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = try ConfigManager.getAPIKEY()
 
        let location = "london"
        return try await client.get(from: FeedEndpoint.getWeather(location).url(baseURL: baseURL, apiKey: apiKey))
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> URLSessionHTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
}
