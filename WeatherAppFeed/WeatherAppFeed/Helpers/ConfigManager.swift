//
//  ConfigManager.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/17/24.
//

import Foundation

final public class ConfigManager {
    enum ConfigError: Error {
        case keyNotFound
        case invalidPath
    }
    
    public static func getAPIKEY() -> String {
        if let path = plist,
            let data = file(at: path),
            let dictionary = try? dictionary(for: data) {
            
            if let plistDictionary = dictionary as? [String: Any] {
                if let apiKey = plistDictionary["API_KEY"] as? String {
                    return apiKey
                } else {
                    assertionFailure("Add your API_KEY to config.plist)")
                }
            }
        }
        fatalError("please add api key in file config.plist")
    }
    
    private static var plist: String? {
        Bundle(for: Self.self).path(forResource: "config", ofType: "plist")
    }
    
    private static func file(at path: String) -> Data? {
        FileManager.default.contents(atPath: path)
    }
    
    private static func dictionary(for data: Data) throws -> Any {
       try PropertyListSerialization
            .propertyList(from: data, options: [], format: nil)
    }
}
 
