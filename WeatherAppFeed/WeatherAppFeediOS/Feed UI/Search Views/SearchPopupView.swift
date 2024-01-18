//
//  SearchPopupView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/18/24.
//

import SwiftUI

struct SearchPopupViewModel {

    var searchWeatherTitle: String {
        NSLocalizedString("SEARCH_WEATHER",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Search weather by city")
    }
    
    var enterCountry: String {
        NSLocalizedString("ENTER_COUNTRY",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Search weather by city")
    }
    
    var cancel: String {
        NSLocalizedString("CANCEL",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Search weather by city")
    }
    
    var search: String {
        NSLocalizedString("SEARCH",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "Search weather by city")
    }
    
    let searchCallBack: WeatherFeed.SearchCallBack
    
    public init(searchCallBack: @escaping WeatherFeed.SearchCallBack) {
        self.searchCallBack = searchCallBack
    }
}

struct SearchPopupView: View {
    @State private var input: String = ""
    @FocusState var isFocused: Bool
    @Binding var isPresented: Bool
    
    public let viewModel: SearchPopupViewModel
    
    public init(isPresented: Binding<Bool>, viewModel: SearchPopupViewModel) {
        _isPresented = isPresented
        self.viewModel = viewModel
    }
    
    var body: some View {
        if !isPresented {
            EmptyView()
        } else {
            ZStack {
                VStack {
                    Text(viewModel.searchWeatherTitle)
                        .font(.title2.bold())
                        .foregroundStyle(.primary.opacity(0.9))
                        .padding(.top, 40)
                    
                    TextField(viewModel.enterCountry, text: $input)
                        .foregroundStyle(.primary)
                        .font(.title.bold())
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(
                            .black.opacity(0.1)
                        )
                        .padding()
                        .padding(.top)
                        .focused($isFocused)
                    
                    HStack(spacing: 1) {
                        Button(role: .cancel, action: { isPresented.toggle() }, label: {
                            Text(viewModel.cancel)
                                .foregroundStyle(.red)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    .regularMaterial
                                )
                        })
                        Button(action: {
                            search()
                        }, label: {
                            Text(viewModel.search)
                                .foregroundStyle(.selection)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    .regularMaterial
                                )
                        })
                    }
                }
                .frame(maxWidth: .infinity,
                       alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.2), lineWidth: 4)
                )
                .background(
                    .thinMaterial
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .onAppear {
                input = ""
                isFocused.toggle()
            }
        }
    }
    
    private func search() {
        guard input.count > 2 else {
            return
        }
        
        viewModel.searchCallBack(input)
        isPresented.toggle()
        isFocused.toggle()
    }
}
