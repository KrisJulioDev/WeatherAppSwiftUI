//
//  WeatherViewModel.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct FeedListView: View {
    typealias DeleteAction = ((WeatherItem) async -> Void)?
    
    private let items: [WeatherItemViewModel]
    private let delete: DeleteAction
    private let refresh: WeatherFeed.SearchCallBack
    private let headerError: WeatherErrorView
    
    public init(items: [WeatherItemViewModel],
                headerError: WeatherErrorView,
                delete: DeleteAction,
                refresh: @escaping WeatherFeed.SearchCallBack) {
        self.items = items
        self.headerError = headerError
        self.delete = delete
        self.refresh = refresh
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: headerError) {
                    ForEach(items, id: \.self) { model in
                        WeatherCard(model.viewModel)
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    Task { await delete?(model.item) }
                                } label: {
                                    Label("Full swipe to delete", systemImage: "trash")
                                        .foregroundStyle(.red)
                                }.tint(.clear)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    refresh(model.item.name)
                                } label: {
                                    Label("Full swipe to refresh", systemImage: "arrow.clockwise")
                                }.tint(.clear)
                            }
                    }
                }
                .background(.clear)
            }
            .background(.clear)
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .background(
                BackgroundImageView()
            )
        }
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
