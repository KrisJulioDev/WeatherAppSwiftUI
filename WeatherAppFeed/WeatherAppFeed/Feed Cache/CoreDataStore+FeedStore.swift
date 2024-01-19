//
//  CoreDataStore+FeedStore.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/19/24.
//

import CoreData

extension CoreDataFeedStore: FeedStore {
    
    public func retrieve() throws -> CachedFeed? {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed($0.localFeed)
                }
            }
        }
    }
    
    public func insert(_ feed: [WeatherItem]) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.feed = ManagedItem.items(from: feed, in: context)
                try context.save()
            }
        }
    }
    
    public func deleteCachedFeed() throws {
        try performSync { context in
            Result {
                try ManagedCache.deleteCache(in: context)
            }
        }
    }
    
}
