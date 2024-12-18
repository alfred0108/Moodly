import SwiftUI

struct CalendarView: View {
    // Properties remain the same
    @State private var date = Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    @EnvironmentObject var weatherDataManager: WeatherDataManager
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                        // Add accessibility
                        .accessibilityLabel("\(daysOfWeek[index]) column")
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                            // Add accessibility
                            .accessibilityHidden(true)
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        weatherDataManager.getWeather(for: day)?.color ??
                                        (Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : .blue.opacity(0.3))
                                    )
                            )
                            // Add accessibility
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("\(day.formatted(.dateTime.month().day()))")
                            .accessibilityValue(getAccessibilityValue(for: day))
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
    
    // Add helper function for accessibility value
    private func getAccessibilityValue(for day: Date) -> String {
        if let weather = weatherDataManager.getWeather(for: day) {
            return "\(weather == .sunny ? "Sunny" : weather == .cloudy ? "Cloudy" : weather == .rainy ? "Rainy" : "Snowy") weather"
        } else if Date.now.startOfDay == day.startOfDay {
            return "Today"
        }
        return "No weather data"
    }
}

#Preview {
    CalendarView()
        .environmentObject(WeatherDataManager())
}
