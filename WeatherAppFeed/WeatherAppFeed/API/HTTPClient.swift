//
//  HTTPClient.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation
 
public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = (Data, URLResponse)
  
    func get(from url: URL) async throws -> Result
}
