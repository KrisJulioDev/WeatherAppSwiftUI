//
//  WeatherViewModel.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI

class WeatherFeedViewModel: ObservableObject {
      
    func feed(with items: [WeatherItemViewModel]) -> some View {
        List(items, id: \.id) { model in
            WeatherCard(model.viewModel)
                .listRowSeparator(.hidden)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .background(.clear)
        .safeAreaPadding(.vertical, 30)
    }
}

struct BackgroundImageView: View {
    var body: some View {
        Image("bg", bundle: Bundle.feed)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
}
