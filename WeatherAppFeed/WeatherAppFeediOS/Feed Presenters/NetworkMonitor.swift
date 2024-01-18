//
//  NetworkMonitor.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/18/24.
//

import Foundation
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
