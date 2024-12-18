//
//  TabbarView.swift
//  WeatherPatic
//
//  Created by Alfredo De Martino on 17/12/24.
//

import SwiftUI

struct TabBarView: View {
    // Add environmentObject
    @EnvironmentObject var weatherDataManager: WeatherDataManager
    
    var body: some View {
        TabView {
            CalendarView()
                .environmentObject(weatherDataManager) // Add this
                .tabItem {
                    Label("Calendario", systemImage: "calendar")
                }
            
            WeatherView()
                .environmentObject(weatherDataManager) // Add this
                .tabItem {
                    Label("Meteo", systemImage: "cloud.sun")
                }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(WeatherDataManager()) // Add this for preview
}
