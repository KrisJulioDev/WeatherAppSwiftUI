//
//  WeatherCard.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI
import WeatherAppFeed

struct WeatherCard: View {
    private let viewModel: WeatherCardViewModel
    
    public init(_ viewModel: WeatherCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        Text(viewModel.name)
                            .font(.title)
                            .foregroundStyle(.primary)
                            .fontWeight(.bold) 
                        
                        Text(viewModel.currentTimeTitle)
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 0.1)
                        
                        Text(viewModel.currentTime)
                            .font(.title)
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        AsyncImage(url: viewModel.weatherIcon) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        
                        Text(viewModel.weatherDescription ?? "No image")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                    }
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                }
                 
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
        .frame(minWidth: 60)
        .frame(maxWidth: 75)
        .background(
            .ultraThickMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    let item = WeatherItem(id: 123, name: "London", country: "US", weatherDescription: "Cloudy", weatherIcon: "04d", temp: 12, feelsLike: 12, pressure: 12, humidity: 12, visibility: 12, windSpeed: 12, rain: 21, dt: 212, clouds: 232)
    
    return WeatherCard(.init(item: item))
}
