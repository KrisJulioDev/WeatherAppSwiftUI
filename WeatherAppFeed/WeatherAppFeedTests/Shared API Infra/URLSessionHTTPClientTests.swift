//
//  URLSessionHTTPClientTests.swift
//  WeatherAppFeedTests
//
//  Created by Khristoffer Julio on 1/16/24.
//

import XCTest
import WeatherAppFeed

final class URLSessionHTTPClientTests: XCTestCase {
        
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    func test_getFromURL_performsGETRequestWithURL() async throws {
        let url = anyURL()
        let exp = expectation(description: "Wait for get completion")
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.httpMethod, "GET", "http method")
            XCTAssertEqual(request.url, url, "URL should be the same")
            exp.fulfill()
        }
        
        try await makeSUT().get(from: url)
        
        await fulfillment(of: [exp])
    }
    
    func test_fetchFromURL_receivesErrorOnErrorResponse() async throws {
        let error = anyNSError()
        URLProtocolStub.stub(data: nil, response: nil, error: error)
        
       try await makeSUT().get(from: anyURL())
       XCTFail("Shouldn't pass this block, expecting error thrown")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> URLSessionHTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
