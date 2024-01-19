//
//  WeatherErrorView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation
import WeatherAppFeed
import SwiftUI

struct WeatherErrorView: View { 
    private let viewModel: WeatherFeedErrorViewModel
    private let tapHandler: () async -> Void
    
    public init(viewModel: WeatherFeedErrorViewModel, tapHandler: @escaping () async -> Void) {
        self.viewModel = viewModel
        self.tapHandler = tapHandler
    }
    
    var body: some View {
        switch viewModel.error {
        case let .noConnection(message), let .noResultFound(message):
            barErrorView(with: message)
                .transition(.move(edge: .top))
        case .noError:
            EmptyView()
        }
    }
    
    private func barErrorView(with message: String) -> some View {
        VStack {
            Button(action: {
                Task {
                    await tapHandler()
                }
            }, label: {
                VStack {
                    Text(message)
                        .foregroundStyle(.white)
                        .font(.headline.bold().monospaced())
                        .multilineTextAlignment(.center)
                        .frame(height: 40)
                }
            })
        }
        .frame(maxWidth: .infinity)
        .background(
            viewModel.errorViewBGColor
        )
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
