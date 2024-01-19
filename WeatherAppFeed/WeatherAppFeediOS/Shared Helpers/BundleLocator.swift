//
//  BundleLocator.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation

extension Bundle {
    public static var feed: Bundle {
        Bundle(for: WeatherFeedViewPresenter.self)
    }
}
