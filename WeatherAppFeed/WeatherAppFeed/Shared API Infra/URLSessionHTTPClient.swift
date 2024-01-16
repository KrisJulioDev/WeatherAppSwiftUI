//
//  URLSessionHTTPClient.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Combine
import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
      
    @discardableResult
    public func get(from url: URL) async throws -> HTTPClient.Result {
        try await session.data(from: url)
    }
}
