//
//  WeatherViewModel.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import WeatherAppFeed
 
struct WeatherViewModel {
    let id: Int
    let item: WeatherItem
    
    public init(item: WeatherItem) {
        self.id = item.id
        self.item = item
    }
    
    var viewModel: WeatherCardViewModel {
        WeatherCardViewModel(item: self.item)
    }
}
