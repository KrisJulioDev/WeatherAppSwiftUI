//
//  ResourceErrorView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/18/24.
//
  
public protocol ResourceErrorView {
    associatedtype ResourceFeedErrorViewModel
    
    func display(_ viewModel: ResourceFeedErrorViewModel)
}
