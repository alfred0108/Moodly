//
//  WeatherPaticApp.swift
//  WeatherPatic
//
//  Created by Alfredo De Martino on 10/12/24.
//

import SwiftUI

@main
struct WeatherPaticApp: App {
    // Initialize WeatherDataManager with mock data
    @StateObject private var weatherDataManager: WeatherDataManager = {
        let manager = WeatherDataManager()
        manager.weatherData = WeatherManager.generateMockData()
        return manager
    }()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(weatherDataManager)
        }
    }
}
