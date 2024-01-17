//
//  RemoteFeedLoader.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//
 
public class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
}
