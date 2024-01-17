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
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.httpMethod, "GET", "http method")
            XCTAssertEqual(request.url, url, "URL should be the same")
        }
        
        try await makeSUT().get(from: url)
    }
    
    func test_fetchFromURL_receivesErrorOnErrorResponse() async throws {
        let error = anyNSError()
        URLProtocolStub.stub(data: nil, response: nil, error: error)
        
        do {
            try await makeSUT().get(from: anyURL())
            XCTFail("Shouldn't pass this block, expecting error thrown")
        } catch {
            XCTAssertNotNil(error, "expects error")
        }
    }
    
    func test_fetchFromURL_receivesDataResponseWithData() async throws {
        let anyData = anyData()
        let anyResponse = anyURLResponse()
        
        URLProtocolStub.stub(data: anyData, response: anyResponse, error: nil)
        
        let (data, response) = try await makeSUT().get(from: anyURL())
        
        XCTAssertEqual(data, anyData, "Expects the same data")
        XCTAssertEqual(response.url, anyResponse.url, "Expects the same url")
        XCTAssertEqual(response.statusCode, anyResponse.statusCode, "Expects the same status code")
    }
    
    func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() async throws {
        let anyResponse = anyURLResponse()
        
        URLProtocolStub.stub(data: nil, response: anyResponse, error: nil)
        
        let (data, response) = try await makeSUT().get(from: anyURL())
        let emptyData = Data()

        XCTAssertEqual(data, emptyData, "Expects no data received")
        XCTAssertEqual(response.url, anyResponse.url, "Expects the same url")
        XCTAssertEqual(response.statusCode, anyResponse.statusCode, "Expects the same status code")
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
}
