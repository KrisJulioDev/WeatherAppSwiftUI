//
//  ConfigManager.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation

final public class ConfigManager {
    enum ConfigError: Error {
        case invalidPlist
        case invalidPath
    }
    
    public static func getAPIKEY() throws -> String {
        if let path = plistPath(),
            let data = FileManager.default.contents(atPath: path),
           let dictionary = try? PropertyListSerialization.propertyList(from: data,
                                                                        options: [],
                                                                        format: nil)
        {
            if let plistDictionary = dictionary as? [String: Any] {
                if let apiKey = plistDictionary["API_KEY"] as? String {
                    return apiKey
                } else {
                    assertionFailure("Add your API_KEY to config.plist)")
                    throw ConfigError.invalidPlist
                }
            }
        }
        assertionFailure("Add your API_KEY to config.plist)")
        throw ConfigError.invalidPath
    }
    
    private static func plistPath() -> String? {
        let plistPath = Bundle(for: Self.self).path(forResource: "config", ofType: "plist")
        return plistPath
    }
}
 
