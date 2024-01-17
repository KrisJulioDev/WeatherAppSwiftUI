//
//  WeatherFeed.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct WeatherFeed: View {
    @EnvironmentObject var observer: WeatherFeedViewPresenter
    @EnvironmentObject var viewModel: WeatherFeedViewModel
    
    var body: some View {
        ZStack {
            viewModel.backgroundImage
            
            ForEach(observer.weatherViewModels, id: \.id) { model in
                WeatherCard(model.viewModel)
            }
        }
        .onAppear {
            observer.addWeather()
        }
    }
}

#Preview {
    return WeatherFeedViewPresenter().compose()
}
