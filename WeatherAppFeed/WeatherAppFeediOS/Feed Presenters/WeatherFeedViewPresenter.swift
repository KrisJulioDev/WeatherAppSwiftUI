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

class WeatherFeedViewModel: ObservableObject {
    var backgroundImage: some View {
        Image("bg", bundle: bundle())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
    
    private func bundle() -> Bundle {
        Bundle(for: WeatherFeedViewPresenter.self)
    }
}

public class WeatherFeedViewPresenter: ObservableObject, ResourceView {
    typealias ResourceViewModel = WeatherViewModel
    
    @Published var weatherViewModels: [WeatherViewModel] = []
    @Published var feedViewModel = WeatherFeedViewModel()
      
    func compose() -> some View {
        WeatherFeed()
            .environmentObject(self)
            .environmentObject(feedViewModel)
    }
    
    func display(_ viewModel: ResourceViewModel) {
        weatherViewModels.append(viewModel)
    }
    
    func addWeather() {
        let viewModel = WeatherViewModel(item: testItem())
        display(viewModel)
    }
    
    private func testItem() -> WeatherItem {
        WeatherItem(id: 2643743, name: "London", country: "US", temp: 271.79, feelsLike: 271.79, tempMin: 270.21, tempMax: 273.13, pressure: 1000, humidity: 84, visibility: 10000, windSpeed: 0.89, rain: 0.94, dt: 1705450380, clouds: 83, timezone: 0)
    }
}

