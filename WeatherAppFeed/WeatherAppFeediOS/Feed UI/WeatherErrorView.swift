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
        ZStack {
            switch viewModel.error {
            case let .noConnection(message), let .noResultFound(message):
                barErrorView(with: message)
            case .noError:
                EmptyView()
            }
        }
        .transition(.move(edge: .top))
        .padding(.top, 50)
    }
    
    private func barErrorView(with message: String) -> some View {
        
        VStack {
            Spacer().frame(height: 10)
            Button(action: {
                Task {
                    await tapHandler()
                }
            }, label: {
                VStack {
                    Text(message)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .multilineTextAlignment(.center)
                        .background(
                            viewModel.errorViewBGColor
                        )
                }
            })
        }
    }
}
