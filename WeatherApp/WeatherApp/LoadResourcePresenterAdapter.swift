//
//  LoadResourcePresenterAdapter.swift
//  WeatherApp
//
//  Created by Khristoffer Julio on 1/18/24.
//

import SwiftUI
import WeatherAppFeed
import WeatherAppFeediOS 

public class LoadResourcePresenterAdapter {
    
    private let remoteLoader: RemoteFeedLoader
    private let localLoader: LocalFeedLoader
    private let presenter: WeatherFeedViewPresenter
    
    private var currentData: [WeatherItem] = []
    
    public init(remoteLoader: RemoteFeedLoader,
                localLoader: LocalFeedLoader,
                presenter: WeatherFeedViewPresenter) {
        self.remoteLoader = remoteLoader
        self.localLoader = localLoader
        self.presenter = presenter
        
        self.presenter.fetchWeather = fetchWeather
        self.presenter.deleteWeather = deleteItem
    }
    
    public func loadInitialResource() async {
        if let localData = try? localLoader.load() {
            currentData = localData
            await setDisplayWith(currentData)
        }
    }
    
    private func fetchWeather(for country: String) async throws {
        Task {
            do {
                let result = try await remoteLoader.load(from: country)
                await didFinishWithResult(result)
            } catch {
                await didFinishWithError(error)
            }
        }
    }
    
    private func deleteItem(_ item: WeatherItem) async {
        let newData = currentData.filter { $0 != item }
        try? localLoader.save(newData)
        currentData = newData
        await setDisplayWith(currentData)
    }
    
    public func composeFeed() -> some View {
        return presenter.compose()
    }
}

extension LoadResourcePresenterAdapter {
    private func didFinishWithResult(_ result: WeatherItem) async {
        refreshIfItemExist(for: result)
        
        currentData.append(result)
        try? localLoader.save(currentData)
        await setDisplayWith(currentData)
    }
    
    private func refreshIfItemExist(for item: WeatherItem) {
        currentData = currentData.filter { $0 != item }
    }
    
    private func setDisplayWith(_ items: [WeatherItem]) async {
        await MainActor.run {
            presenter.display(items.map { WeatherItemViewModel(item: $0) })
        }
    }
    
    private func didFinishWithError(_ error: Error) async {
        guard let error = error as? RemoteFeedLoader.ViewError else {
            return
        }
        
        await MainActor.run {
            presenter.display(WeatherFeedErrorViewModel(error))
        }
    }
}
