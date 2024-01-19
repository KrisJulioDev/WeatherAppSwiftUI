//
//  FeedStore.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation

public typealias CachedFeed = [WeatherItem]
 
public protocol FeedStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [WeatherItem]) throws
    func retrieve() throws -> CachedFeed?
}
