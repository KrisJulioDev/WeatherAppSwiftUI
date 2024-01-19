//
//  LocalFeedLoader.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/19/24.
//

public protocol FeedCache {
    func save(_ feed: [WeatherItem]) throws
}

public final class LocalFeedLoader {
    private let store: FeedStore
    
    public init(store: FeedStore) {
        self.store = store
    }
}

extension LocalFeedLoader: FeedCache {
    public func save(_ feed: [WeatherItem]) throws {
        try store.deleteCachedFeed()
        try store.insert(feed)
    }
}

extension LocalFeedLoader {
    public func load() throws -> [WeatherItem] {
        if let cache = try store.retrieve() {
            return cache
        }
        return []
    }
}
