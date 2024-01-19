//
//  ManagedItem.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/19/24.
//

import CoreData

@objc(ManagedItem)
class ManagedItem: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var country: String
    @NSManaged var weatherDescription: String?
    @NSManaged var weatherIcon: String?
    @NSManaged var temp: CGFloat
    @NSManaged var feelsLike: CGFloat
    @NSManaged var pressure: CGFloat
    @NSManaged var humidity: CGFloat
    @NSManaged var visibility: CGFloat
    @NSManaged var windSpeed: CGFloat
    @NSManaged var rain: CGFloat
    @NSManaged var dt: Int
    @NSManaged var clouds: Int
    @NSManaged var cache: ManagedCache
}

extension ManagedItem {
    static func items(from localFeed: [WeatherItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        let images = NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedItem(context: context)
            managed.id = local.id
            managed.name = local.name
            managed.country = local.country
            managed.weatherDescription = local.weatherDescription
            managed.weatherIcon = local.weatherIcon
            managed.temp = local.temp
            managed.feelsLike = local.feelsLike
            managed.pressure = local.pressure
            managed.humidity = local.humidity
            managed.visibility = local.visibility
            managed.windSpeed = local.windSpeed
            managed.rain = local.rain ?? 0
            managed.dt = local.dt
            managed.clouds = local.clouds
            
            return managed
        })
        context.userInfo.removeAllObjects()
        return images
    }
    
    var local: WeatherItem {
        WeatherItem(id: id, name: name, country: country, weatherDescription: weatherDescription, weatherIcon: weatherIcon, temp: temp, feelsLike: feelsLike, pressure: pressure, humidity: humidity, visibility: visibility, windSpeed: windSpeed, rain: rain, dt: dt, clouds: clouds)
    }
}
