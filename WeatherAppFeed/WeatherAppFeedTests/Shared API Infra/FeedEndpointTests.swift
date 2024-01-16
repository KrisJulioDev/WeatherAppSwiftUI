//
//  FeedEndpointTests.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//

import XCTest
import WeatherAppFeed

final class FeedEndpointTests: XCTestCase {
    func test_feed_endpointURLWithNoIntervalAndDefaultUnit() {
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = "sampleApiKey"
        let query = WeatherQuery(latitude: "90", longitude: "50")
        let received = FeedEndpoint.getWeather(query).url(baseURL: baseURL, apiKey: apiKey)
        
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/data/3.0/onecall", "path")
        XCTAssertEqual(received.query, "lat=90&lon=50&appid=sampleApiKey&units=standard", "query")
    }
    
    func test_feed_endpointURLWithIntervalsAndSelectedUnits() {
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let apiKey = "correct-api-key"
        let query = WeatherQuery(latitude: "10",
                                 longitude: "20",
                                 interval: [.alerts, .current, .daily, .hourly, .minutely],
                                 unit: .metric)
        let received = FeedEndpoint.getWeather(query).url(baseURL: baseURL, apiKey: apiKey)
        
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/data/3.0/onecall", "path")
        XCTAssertEqual(received.query, "lat=10&lon=20&appid=correct-api-key&units=metric&exclude=alerts,current,daily,hourly,minutely", "query")
    }
}
