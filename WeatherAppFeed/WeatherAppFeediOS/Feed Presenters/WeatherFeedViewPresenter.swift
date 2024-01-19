//
//  WeatherFeedViewPresenter.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import WeatherAppFeed
import SwiftUI

public class WeatherFeedErrorViewModel: ObservableObject {
    @Published var error: RemoteFeedLoader.ViewError = .noError
     
    var errorViewBGColor: Color {
        Color("errorColor", bundle: Bundle.feed)
    }
    
    public init(_ error: RemoteFeedLoader.ViewError = .noError) {
        self.error = error
    }
}

public class WeatherFeedViewPresenter: ObservableObject,
                                        ResourceView, ResourceErrorView {
    public typealias ResourceViewModel = WeatherItemViewModel
    public typealias ResourceFeedErrorViewModel = WeatherFeedErrorViewModel
    
    @Published var itemViewModels: [WeatherItemViewModel] = []
    @Published var feedViewModel = WeatherFeedViewModel()
    @Published var errorViewModel = WeatherFeedErrorViewModel()
    
    private var title: String {
        NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Title for the feed view")
    }
    
    public var fetchWeather: ((String) async throws -> Void)?
    
    public init() {}
    
    public func compose() -> some View {
        WeatherFeed(title: title)
            .environmentObject(self)
            .environmentObject(feedViewModel)
            .environmentObject(errorViewModel)
    }
    
    public func display(_ viewModel: WeatherItemViewModel) {
        itemViewModels.append(viewModel)
    }
    
    public func display(_ viewModel: WeatherFeedErrorViewModel) {
        errorViewModel.error = viewModel.error
    }
} 
