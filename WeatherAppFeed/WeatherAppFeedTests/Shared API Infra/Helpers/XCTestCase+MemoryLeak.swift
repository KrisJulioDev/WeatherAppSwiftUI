//
//  XCTestCase+MemoryLeak.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//
 
import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
