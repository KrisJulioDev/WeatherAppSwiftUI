//
//  ResourceView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/18/24.
//
 
public protocol ResourceView {
    associatedtype ResourceViewModel
    
    func display(_ viewModel: ResourceViewModel)
}
