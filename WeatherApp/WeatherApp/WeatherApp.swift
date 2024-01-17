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
    let presenter = WeatherFeedViewPresenter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                presenter.compose()
            }
        }
    }
} 
