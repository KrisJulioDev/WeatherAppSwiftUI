//
//  LoadResourcePresenterAdapter.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/18/24.
//

import SwiftUI
import WeatherAppFeed
import WeatherAppFeediOS

public class LoadResourcePresenterAdapter: ResourceView, ResourceErrorView {
    
    public typealias ResourceViewModel = WeatherItemViewModel
    public typealias ResourceFeedErrorViewModel = WeatherFeedErrorViewModel
    
    private let client: HTTPClient
    private let presenter: WeatherFeedViewPresenter
    
    public init(client: HTTPClient, presenter: WeatherFeedViewPresenter) {
        self.client = client
        self.presenter = presenter
    }
    
    public func loadWeather(for country: String) {
        
    }
    
    public func composeFeed() -> some View {
        return presenter.compose()
    }
    
    public func display(_ viewModel: ResourceViewModel) {
        presenter.display(viewModel)
    }
    
    public func display(_ viewModel: ResourceFeedErrorViewModel) {
        presenter.display(viewModel)
    }
}
