//
//  NullStore.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/19/24.
//
import WeatherAppFeed

class NullStore {}

extension NullStore: FeedStore {
    func deleteCachedFeed() throws {}
    
    func insert(_ feed: [WeatherItem]) throws {}
    
    func retrieve() throws -> CachedFeed? { .none }
} 
