//
//  HTTPStatusCode.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/16/24.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
