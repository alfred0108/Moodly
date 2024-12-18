//
//  WeatherView.swift
//  WeatherPatic
//

import SwiftUI

struct WeatherView: View {
    // Properties remain the same
    @EnvironmentObject var weatherDataManager: WeatherDataManager
    @State private var showingAddSheet = false
    @State private var selectedMood: Mood = .happy
    @State private var selectedWeather: Weather = .sunny
    
    // Weather stats remain the same
    var weatherStats: [(weather: Weather, emoji: String, count: Int)] {
        [
            (.sunny, "☀️", weatherDataManager.weatherData.filter { $0.weather == .sunny }.count),
            (.cloudy, "☁️", weatherDataManager.weatherData.filter { $0.weather == .cloudy }.count),
            (.rainy, "🌧️", weatherDataManager.weatherData.filter { $0.weather == .rainy }.count),
            (.snowy, "❄️", weatherDataManager.weatherData.filter { $0.weather == .snowy }.count)
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(weatherStats, id: \.weather) { stat in
                    HStack {
                        Text(stat.emoji)
                            .font(.title)
                        Spacer()
                        Text("\(stat.count)/\(weatherDataManager.weatherData.count)")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                    // Add accessibility
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(stat.weather) weather")
                    .accessibilityValue("\(stat.count) days out of \(weatherDataManager.weatherData.count)")
                }
            }
            .navigationTitle("Weather Stats")
            .toolbar {
                Button(action: { showingAddSheet = true }) {
                    Image(systemName: "plus")
                        // Add accessibility
                        .accessibilityLabel("Add new weather entry")
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationView {
                    Form {
                        Picker("Mood", selection: $selectedMood) {
                            ForEach([Mood.happy, .angry, .calm, .sad], id: \.self) { mood in
                                Text(mood.rawValue.capitalized)
                                    // Add accessibility
                                    .accessibilityLabel("\(mood.rawValue) mood")
                            }
                        }
                        
                        Picker("Weather", selection: $selectedWeather) {
                            ForEach([Weather.sunny, .cloudy, .rainy, .snowy], id: \.self) { weather in
                                Text(weather == .sunny ? "Sunny" :
                                     weather == .cloudy ? "Cloudy" :
                                     weather == .rainy ? "Rainy" : "Snowy")
                                    // Add accessibility
                                    .accessibilityLabel("\(weather == .sunny ? "Sunny" : weather == .cloudy ? "Cloudy" : weather == .rainy ? "Rainy" : "Snowy") weather")
                            }
                        }
                    }
                    .navigationTitle("Add Daily Entry")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingAddSheet = false
                        }
                        // Add accessibility
                        .accessibilityLabel("Cancel adding weather entry")
                        ,
                        trailing: Button("Save") {
                            let newDay = WeatherDay(date: Date(), weather: selectedWeather, mood: selectedMood)
                            weatherDataManager.weatherData.append(newDay)
                            showingAddSheet = false
                        }
                        // Add accessibility
                        .accessibilityLabel("Save weather entry")
                    )
                }
            }
        }
    }
}

// Preview remains the same
#Preview {
    WeatherView()
        .environmentObject(WeatherDataManager())
}
