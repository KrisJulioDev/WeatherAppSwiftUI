//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed
import WeatherAppFeediOS

@main
struct WeatherApp: App {
    
    private let loadResourcePresenter: LoadResourcePresenterAdapter = {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let viewPresenter = WeatherFeedViewPresenter()
        return LoadResourcePresenterAdapter(client: client, presenter: viewPresenter)
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                loadResourcePresenter.composeFeed()
            }
        }
    }
}
 
