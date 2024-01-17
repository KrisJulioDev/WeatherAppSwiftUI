//
//  FeedEndpointTests.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//

import XCTest
import WeatherAppFeed

final class FeedEndpointTests: XCTestCase {
    func test_feed_endpointURLWithEmpyLocation() {
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = "sampleApiKey"
        let received = FeedEndpoint.getWeather("").url(baseURL: baseURL, apiKey: apiKey)
        
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/data/2.5/weather", "path")
        XCTAssertEqual(received.query, "q=&appid=sampleApiKey", "query")
    }

    func test_feed_endpointURLWithIntervalsAndSelectedUnits() {
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = "correct-api-key"
        let received = FeedEndpoint.getWeather("london").url(baseURL: baseURL, apiKey: apiKey)
        
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/data/2.5/weather", "path")
        XCTAssertEqual(received.query, "q=london&appid=correct-api-key", "query")
    }
}
