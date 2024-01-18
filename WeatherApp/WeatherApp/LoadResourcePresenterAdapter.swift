//
//  LoadResourcePresenterAdapter.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/18/24.
//

import SwiftUI
import WeatherAppFeed
import WeatherAppFeediOS 

public class LoadResourcePresenterAdapter {
    
    private let loader: RemoteFeedLoader
    private let presenter: WeatherFeedViewPresenter
    
    private enum LoadError: Error {
        case invalidAPIKey
    }
    
    public init(loader: RemoteFeedLoader, presenter: WeatherFeedViewPresenter) {
        self.loader = loader
        self.presenter = presenter
        self.presenter.fetchWeather = fetchWeather
    }
     
    private func fetchWeather(for country: String) async throws {
        Task {
            do {
                let result = try await loader.load(from: country)
                
                await MainActor.run {
                    presenter.display(WeatherItemViewModel(item: result))
                }
            } catch {
                guard let error = error as? RemoteFeedLoader.ViewError else {
                    return
                }
                
                await MainActor.run {
                    presenter.display(WeatherFeedErrorViewModel(error))
                }
            }
        }
    }
    
    public func composeFeed() -> some View {
        return presenter.compose()
            .navigationTitle("Weather App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.black.opacity(0.05), for: .navigationBar)
    }
}
