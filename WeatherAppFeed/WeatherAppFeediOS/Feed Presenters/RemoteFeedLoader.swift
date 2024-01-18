//
//  RemoteFeedLoader.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/18/24.
//
 
import Network
import WeatherAppFeed

public class RemoteFeedLoader {
    public let baseURL: URL
    public let APIKey: String
    public let httpClient: HTTPClient
    public let networkMonitor: NetworkMonitor
    
    private let maxRetries = 3
    private var retries = 0
     
    public enum ViewError: Error {
        case noError
        case noConnection(String)
        case noResultFound(String)
    }
    
    public init(baseURL: URL, APIKey: String, httpClient: HTTPClient, networkMonitor: NetworkMonitor) {
        self.baseURL = baseURL
        self.APIKey = APIKey
        self.httpClient = httpClient
        self.networkMonitor = networkMonitor
    }
    
    public func load(from country: String) async throws -> WeatherItem {
        let url = FeedEndpoint
            .getWeather(country)
            .url(baseURL: baseURL, apiKey: APIKey)
            
        let (data, response) = try await httpClient.get(from: url)
        
        do {
            let result = try WeatherItemMapper.map(data, from: response)
            return result
        } catch {
            if networkMonitor.isConnected {
                throw ViewError.noResultFound("No result found, try again")
            } else if retries < maxRetries {
                retries += 1
                return try await load(from: country)
            } else {
                throw ViewError.noConnection("Couldn't reach the server.")
            }
        }
    }
}
