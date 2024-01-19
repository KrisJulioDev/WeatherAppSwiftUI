//
//  WeatherFeed.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct WeatherFeedViewModel {
    
    var navColor: Color {
        Color("navColor", bundle: Bundle.feed)
    }
    
    var title: String {
        NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Title for the feed view")
    }
}

struct WeatherFeed: View {
    public typealias SearchCallBack = ((String) -> Void)
    private typealias WeatherError = WeatherFeedErrorViewModel
    private let viewModel = WeatherFeedViewModel()
    
    @EnvironmentObject var presenter: WeatherFeedViewPresenter
    @EnvironmentObject var errorViewModel: WeatherFeedErrorViewModel
    @State private var showSearchPopup: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundImageView()
            FeedListView(items: presenter.itemViewModels)
            SearchBarView(searchCallback: showPopupToggle)
        }
        .overlay {
            if presenter.itemViewModels.isEmpty {
                EmptyWeatherView(callback: showPopupToggle)
            }
            
            SearchPopupView(isPresented: $showSearchPopup,
                            viewModel: SearchPopupViewModel(searchCallBack: search))
            
            WeatherErrorView(viewModel: errorViewModel, tapHandler: resetError)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle(Text(viewModel.title).foregroundStyle(.white))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(viewModel.navColor, for: .navigationBar)
    }
}

extension WeatherFeed {
    private func search(input: String) {
        Task {
            await resetError()
            try await presenter.fetchWeather?(input)
        }
    }
    
    private func showPopupToggle() {
        withAnimation {
            showSearchPopup.toggle()
        }
    }
    
    private func resetError() async {
        await MainActor.run {
            presenter.display(WeatherError(.noError))
        }
    }
}

#Preview {
    NavigationStack {
        WeatherFeedViewPresenter().compose()
    }
}
