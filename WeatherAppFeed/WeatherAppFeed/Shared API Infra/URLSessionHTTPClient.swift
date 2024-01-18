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
    
    enum HTTPError: Swift.Error {
        case invalidResponse
        case fetchError(Error)
    }
      
    @discardableResult
    public func get(from url: URL) async throws -> HTTPClient.Result {
        do {
            let (data, response) = try await session.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                return (data, httpResponse)
            } else {
                throw HTTPError.invalidResponse
            }
        } catch {
            throw HTTPError.fetchError(error)
        }
    }
}
