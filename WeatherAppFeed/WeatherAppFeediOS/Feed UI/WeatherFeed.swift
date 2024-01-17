//
//  WeatherFeed.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct WeatherFeed: View {
    private typealias WeatherError = WeatherFeedErrorViewModel
    
    @EnvironmentObject var presenter: WeatherFeedViewPresenter
    @EnvironmentObject var viewModel: WeatherFeedViewModel
    @EnvironmentObject var errorViewModel: WeatherFeedErrorViewModel
    
    private let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack {
            viewModel.backgroundImage
            viewModel.feed(with: presenter.itemViewModels)
            WeatherErrorView(viewModel: errorViewModel,
                             tapHandler: didTapError)
            SearchBarView()
        }
        .onAppear {
            presenter.addWeather()
            presenter.addWeather()
            presenter.addWeather()
        } 
    }
    
    private func didTapError() {
        presenter.display(WeatherError(currentState: .noError))
    }
}

#Preview {
    NavigationStack {
        WeatherFeedViewPresenter().compose()
    }
}
