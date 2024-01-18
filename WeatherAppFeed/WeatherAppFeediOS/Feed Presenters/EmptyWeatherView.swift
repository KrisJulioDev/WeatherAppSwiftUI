//
//  EmptyWeatherView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/19/24.
//

import SwiftUI

public struct EmptyWeatherView: View {
    private let viewModel = EmptyWeatherViewModel()
    
    let callback: () -> Void
    
    public init(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label(viewModel.title, systemImage: "cloud.sun")
        } description: {
            Text(viewModel.discoverString)
        } actions: {
            Button(viewModel.searchString) {
                callback()
            }
            .buttonStyle(.borderedProminent)
        }
        .background(
            Color(uiColor: UIColor.systemBackground)
        )
    }
}

private struct EmptyWeatherViewModel {
    var title: String {
        NSLocalizedString("EMPTY_WEATHER",
                          tableName: "Feed",
                          bundle: Bundle.feed,
                          comment: "")
    }
    
    var discoverString: String {
        NSLocalizedString("DISCOVER_WEATHER",
                          tableName: "Feed",
                          bundle: Bundle.feed,
                          comment: "")
    }
    
    var searchString: String {
        NSLocalizedString("SEARCH_CITY",
                          tableName: "Feed",
                          bundle: Bundle.feed,
                          comment: "")
    }
    
} 
