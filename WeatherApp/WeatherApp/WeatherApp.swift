//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import Combine
import CoreData
import WeatherAppFeed
import WeatherAppFeediOS
 
@main
struct WeatherApp: App {
    private let loadResourcePresenter = LoadResourcePresenterAdapter.createDependencies()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                loadResourcePresenter.composeFeed()
            }
            .onAppear {
                Task {
                    await loadResourcePresenter.loadResource()
                }
            }
        }
    }
}

extension LoadResourcePresenterAdapter {
    static func createDependencies() -> LoadResourcePresenterAdapter {
        let store: FeedStore = {
            do {
                return try CoreDataFeedStore(
                    storeURL: NSPersistentContainer
                        .defaultDirectoryURL()
                        .appendingPathComponent("feed-store.sqlite"))
            } catch {
                assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
                return NullStore()
            }
        }()
        
        let baseUrl = URL(string: "https://api.openweathermap.org")!
        let apiKey = ConfigManager.getAPIKEY()
        let httpClient: HTTPClient = URLSessionHTTPClient(
            session: URLSession(configuration: .ephemeral)
        )
        
        let networkMonitor = NetworkMonitor()
        
        let remoteLoader = RemoteFeedLoader(baseUrl: baseUrl,
                                            apiKey: apiKey,
                                            httpClient: httpClient,
                                            networkMonitor: networkMonitor)
        
        let localLoader = LocalFeedLoader(store: store)
        let viewPresenter = WeatherFeedViewPresenter()
        
        return LoadResourcePresenterAdapter(
            remoteLoader: remoteLoader,
            localLoader: localLoader,
            presenter: viewPresenter
        )
    }
}
