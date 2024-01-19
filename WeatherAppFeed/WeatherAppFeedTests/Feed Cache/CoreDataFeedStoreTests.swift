//
//  CoreDataFeedStoreTests.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/19/24.
//

import XCTest
import WeatherAppFeed

final class CoreDataFeedStoreTests: XCTestCase {
    
    func test_retrieve_deliversNoDataOnEmptyCache() {
        let sut = makeSUT()
            
        expects(sut, toRetrieve: .success(nil))
    }

    func test_insert_retrievesDataOnNonEmptyCache() {
        let sut = makeSUT()
        let item = [makeValidItem().model]
        
        try? sut.insert(item)
        
        expects(sut, toRetrieve: .success(item))
    }
    
    func test_insertAndDelete_deliversNoData() {
        let sut = makeSUT()
        let item = [makeValidItem().model]
         
        try? sut.insert(item)
        
        expects(sut, toRetrieve: .success(.some(item)))
        
        try? sut.deleteCachedFeed()
        
        expects(sut, toRetrieve: .success(nil))
    }
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> FeedStore {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = try! CoreDataFeedStore(storeURL: storeURL)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func expects(_ sut: FeedStore, toRetrieve expectedResult: Result<CachedFeed?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        
        let retrievedResult = Result { try sut.retrieve() }
         
        switch (expectedResult, retrievedResult) {
                 
        case let (.success(expected), .success(retrieved)):
            XCTAssertEqual(expected, retrieved, file: file, line: line)
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}
