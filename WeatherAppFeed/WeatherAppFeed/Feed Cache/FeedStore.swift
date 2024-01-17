//
//  FeedStore.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation

public typealias CachedFeed = (feed: [WeatherItem], timestamp: Date)
 
public protocol FeedStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [WeatherItem], timestamp: Date) throws
    func retrieve() throws -> CachedFeed?
}
