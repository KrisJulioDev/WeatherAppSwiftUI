//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import Combine
import WeatherAppFeed
import WeatherAppFeediOS
 
@main
struct WeatherApp: App {

    private let loadResourcePresenter: LoadResourcePresenterAdapter = {
        let baseURL = URL(string: "https://api.openweathermap.org")!
        let APIKey = ConfigManager.getAPIKEY()
        let httpClient: HTTPClient = {
            URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        }()
        let networkMonitor = NetworkMonitor()
        
        let loader = RemoteFeedLoader(baseURL: baseURL, APIKey: APIKey, httpClient: httpClient, networkMonitor: networkMonitor)
        
        let viewPresenter = WeatherFeedViewPresenter()
        return LoadResourcePresenterAdapter(loader: loader, presenter: viewPresenter)
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                loadResourcePresenter.composeFeed()
            }
        }
    }
}
