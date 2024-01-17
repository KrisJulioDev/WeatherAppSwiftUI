//
//  WeatherFeedViewPresenter.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import WeatherAppFeed
import SwiftUI
 
protocol ResourceView {
    associatedtype ResourceViewModel
    
    func display(_ viewModel: ResourceViewModel)
}

protocol ResourceErrorView {
    associatedtype ResourceFeedErrorViewModel
    
    func display(_ viewModel: ResourceFeedErrorViewModel)
}

public class WeatherFeedErrorViewModel: ObservableObject {
    @Published private(set) var currentState: State = .noError
    
    public enum State {
        case noError
        case noConnection(String)
    }
     
    var errorViewBGColor: Color {
        Color("errorColor", bundle: Bundle.feed)
    }
    
    public init(currentState: State = .noError) {
        self.currentState = currentState
    }
    
    public func setState(_ state: State) {
        currentState = state
    }
}

public class WeatherFeedViewPresenter: ObservableObject, 
                                        ResourceView, ResourceErrorView {
    typealias ResourceViewModel = WeatherItemViewModel
    typealias ResourceFeedErrorViewModel = WeatherFeedErrorViewModel
    
    @Published var itemViewModels: [WeatherItemViewModel] = []
    @Published var feedViewModel = WeatherFeedViewModel()
    @Published var errorViewModel = WeatherFeedErrorViewModel()
    
    private var title: String {
        NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Title for the feed view")
    }
    
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
        errorViewModel.setState(viewModel.currentState)
    }
}

extension WeatherFeedViewPresenter {
    func addWeather() {
        let viewModel = WeatherItemViewModel(item: testItem(id: (0...1000).randomElement()!))
        display(viewModel)
    }
    
    private func testItem(id: Int) -> WeatherItem {
        WeatherItem(id: id, name: "London", country: "US", temp: 271.79, feelsLike: 271.79, tempMin: 270.21, tempMax: 273.13, pressure: 1000, humidity: 84, visibility: 10000, windSpeed: 0.89, rain: 0.94, dt: 1705450380, clouds: 83, timezone: 0)
    }
}
