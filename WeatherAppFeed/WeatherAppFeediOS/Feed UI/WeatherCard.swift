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
    let value: String
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
            
            WeatherInfo(title: "Wind",
                        value: String(item.windSpeed),
                        image: Image(systemName: "wind")),
        ]
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
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("CURRENT TIME")      
                    .foregroundStyle(.gray.opacity(0.8))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 0.1)
                
                Text(viewModel.currentTime)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                 
                Text("TODAY'S FORECAST")
                    .foregroundStyle(.gray.opacity(0.8))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                
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
                    .stroke(.white.opacity(0.4), lineWidth: 4)
            )
            .background(
                .thinMaterial
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black.opacity(0.2), lineWidth: 2)
        )
        .safeAreaPadding()
        .shadow(radius: 5)
    }
}

struct LabelView: View {
    private let weatherInfo: WeatherInfo
    
    init(weatherInfo: WeatherInfo) {
        self.weatherInfo = weatherInfo
    }

    var body: some View {
        VStack {
            VStack {
                weatherInfo.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                Text(weatherInfo.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontDesign(.monospaced)
                    .padding(.top, 0.5)
                
                Text(weatherInfo.value)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fontDesign(.monospaced)
                
            }
            .padding()
        }
        .background(
            .thinMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    return WeatherFeedViewPresenter().compose()
}
