//
//  NetworkMonitor.swift
//  WeatherAppFeed
//
//  Created by Khristoffer Julio on 1/19/24.
//
 
import Network

@Observable
public class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    public init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
