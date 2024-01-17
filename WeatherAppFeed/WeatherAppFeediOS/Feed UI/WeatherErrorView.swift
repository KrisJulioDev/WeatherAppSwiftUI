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
    private let tapHandler: () -> Void
    
    public init(viewModel: WeatherFeedErrorViewModel, tapHandler: @escaping () -> Void) {
        self.viewModel = viewModel
        self.tapHandler = tapHandler
    }
    
    var body: some View {
        ZStack {
            switch viewModel.currentState {
            case let .noConnection(message):
                Button(action: {
                    tapHandler()
                }, label: {
                    Text(message)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            viewModel.errorViewBGColor
                        )
                })
            case .noError:
                EmptyView()
            }
        }
    }
}
