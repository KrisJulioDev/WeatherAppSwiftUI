//
//  WeatherCard.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct WeatherInfo {
    let title: String
    let value: String?
    let image: Image
}

struct WeatherCardViewModel {
    private let item: WeatherItem
    
    public init(item: WeatherItem) {
        self.item = item
    }
    
    var name: String {
        item.name + ", " + item.country
    }
    
    var currentTimeTitle: String {
        NSLocalizedString("CURRENT_TIME",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "current time title")
    }
    
    var todaysForecastTitle: String {
        NSLocalizedString("TODAYS_FORECAST",
            tableName: "Feed",
            bundle: Bundle(for: WeatherFeedViewPresenter.self),
            comment: "todaysForecast title")
    }
    
    var currentTime: String {
        let timestamp = TimeInterval(1705464189)
        let date = Date(timeIntervalSince1970: timestamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss aa"

        return dateFormatter.string(from: date)
    }
    
    var weatherInfo: [WeatherInfo] {
        [
            WeatherInfo(title: "Feels",
                        value: String(item.feelsLike),
                        image: Image(systemName: "thermometer.medium")),
            
            WeatherInfo(title: "Humid",
                        value: String(item.humidity),
                        image: Image(systemName: "humidity.fill")),
            
            WeatherInfo(title: "Rain",
                        value: item.rain == nil ? nil : String(item.rain!),
                        image: Image(systemName: "cloud.rain.fill")),
            
            WeatherInfo(title: "Wind",
                        value: String(item.windSpeed),
                        image: Image(systemName: "wind")),
        ]
        .filter { $0.value != nil }
    }
     
}

struct WeatherCard: View {
    private let viewModel: WeatherCardViewModel
    
    public init(_ viewModel: WeatherCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.name)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.currentTimeTitle)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 0.1)
                
                Text(viewModel.currentTime)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                 
                Text(viewModel.todaysForecastTitle)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 1)
                
                Divider().frame(height: 2)
                
                HStack {
                    ForEach(viewModel.weatherInfo, id: \.title) { info in
                        LabelView(weatherInfo: info)
                    }
                }
                .padding(.top, 10)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.primary.opacity(0.1), lineWidth: 4)
            )
            .background(
                .thinMaterial
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .listRowSeparator(.hidden)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.primary.opacity(0.1), lineWidth: 2)
        )
        .shadow(radius: 5)
        .listRowBackground(Color.clear)
    }
}

struct LabelView: View {
    private let weatherInfo: WeatherInfo
    
    init(weatherInfo: WeatherInfo) {
        self.weatherInfo = weatherInfo
    }

    var body: some View {
        VStack {
            VStack(alignment: .center) {
                weatherInfo.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                Text(weatherInfo.title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .fontDesign(.monospaced)
                    .padding(.top, 0.5)
                
                Text(weatherInfo.value ?? "")
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .fontDesign(.monospaced)
                
            }
            .padding(.vertical)
        }
        .frame(width: 75)
        .background(
            .ultraThickMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    return WeatherFeedViewPresenter().compose()
}
