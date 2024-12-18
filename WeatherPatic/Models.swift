//
//  Models.swift
//  WeatherPatic
//
//  Created by Alfredo De Martino on 17/12/24.
//

import Foundation
import SwiftUI

// Weather enum definition
enum Weather {
    case sunny, cloudy, rainy, snowy
    
    // Add color property
    var color: Color {
        switch self {
        case .sunny: return .blue
        case .cloudy: return .gray.opacity(0.3)
        case .rainy: return .gray.opacity(0.7)
        case .snowy: return Color(red: 0.7, green: 0.9, blue: 1.0)
        }
    }
}

// Rest of the models remain the same
enum Mood: String {
    case happy, angry, calm, sad
    
    var color: Color {
        switch self {
        case .happy: return .blue.opacity(0.5)
        case .angry: return .red.opacity(0.5)
        case .calm: return .green.opacity(0.5)
        case .sad: return .gray.opacity(0.5)
        }
    }
}

// Add observable object to store weather data
class WeatherDataManager: ObservableObject {
    @Published var weatherData: [WeatherDay] = []
    
    func getWeather(for date: Date) -> Weather? {
        weatherData.first{ Calendar.current.isDate($0.date, inSameDayAs: date) }?.weather
    }
}

// WeatherDay model remains the same
struct WeatherDay: Identifiable {
    let id = UUID()
    let date: Date
    let weather: Weather
    let mood: Mood
}

// WeatherManager remains the same
struct WeatherManager {
    static func generateMockData() -> [WeatherDay] {
        let sampleDates = (0..<30).map { Calendar.current.date(byAdding: .day, value: $0, to: Date())! }
        let moods: [Mood] = [.happy, .angry, .calm, .sad]
        let weathers: [Weather] = [.sunny, .rainy, .cloudy, .snowy]
        
        return sampleDates.map {
            WeatherDay(
                date: $0,
                weather: weathers.randomElement()!,
                mood: moods.randomElement()!
            )
        }
    }
}
