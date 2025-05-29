//
//  WeatherData.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation

/// Stores current weather data for the immersive space experience
@Observable
class WeatherData {
    // MARK: - Core Weather Properties
    
    /// Current weather condition description
    var condition: String = "Clear"
    
    /// Current temperature in Celsius
    var temperature: Double = 20.0
    
    /// Wind speed in km/h
    var windSpeed: Double = 0.0
    
    /// Wind direction in degrees
    var windDirection: Double = 0.0
    
    /// Cloud coverage percentage (0-100)
    var cloudCoverage: Double = 0.0
    
    /// Visibility in kilometers
    var visibility: Double = 10.0
    
    /// Humidity percentage (0-100)
    var humidity: Double = 50.0
    
    /// UV Index (0-11+)
    var uvIndex: Int = 0
    
    // MARK: - Location Properties
    
    /// Display name of the location
    var locationName: String = "Unknown Location" // FIXED: Better default name
    
    /// Location coordinates
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    /// Time zone for the location
    var timeZone: TimeZone = TimeZone.current
    
    /// Local time at the location
    var localTime: Date = Date()
    
    // MARK: - State Properties
    
    /// Loading state
    var isLoading: Bool = false
    
    /// Error message if weather fetch fails
    var errorMessage: String?
    
    /// Last update timestamp
    var lastUpdated: Date?
    
    // MARK: - Update Methods
    
    /// Updates weather data from WeatherKit CurrentWeather
    func update(from weather: CurrentWeather, location: CLLocation?, placemark: CLPlacemark?) {
        // Core weather data
        condition = weather.condition.description
        temperature = weather.temperature.converted(to: .celsius).value
        windSpeed = weather.wind.speed.converted(to: .kilometersPerHour).value
        windDirection = weather.wind.direction.converted(to: .degrees).value
        cloudCoverage = weather.cloudCover * 100 // Convert to percentage
        visibility = weather.visibility.converted(to: .kilometers).value
        humidity = weather.humidity * 100 // Convert to percentage
        uvIndex = weather.uvIndex.value
        
        // Location data
        if let location = location {
            coordinate = location.coordinate
        }
        
        // IMPORTANT: Do NOT override locationName here if it's already been set properly
        // The calling code should handle setting locationName explicitly
        if let placemark = placemark {
            let possibleName = placemark.locality ?? placemark.administrativeArea ?? placemark.country
            if let validName = possibleName, !validName.isEmpty, locationName == "Unknown Location" {
                locationName = validName
            }
        }
        
        // Time data
        localTime = weather.date
        lastUpdated = Date()
        
        // Clear any previous errors
        errorMessage = nil
        isLoading = false
        
        print("📊 WeatherData updated:")
        print("   🌤️ Condition: \(condition)")
        print("   🌡️ Temperature: \(Int(temperature))°C")
        print("   💨 Wind: \(Int(windSpeed)) km/h")
        print("   🧭 Wind direction: \(Int(windDirection))°")
        print("   ☁️ Cloud coverage: \(Int(cloudCoverage))%")
        print("   🌍 Location: \(locationName)")
        print("   ⏰ Local time: \(localTime)")
    }
    
    /// Clears all weather data
    func clear() {
        condition = "Clear"
        temperature = 20.0
        windSpeed = 0.0
        windDirection = 0.0
        cloudCoverage = 0.0
        visibility = 10.0
        humidity = 50.0
        uvIndex = 0
        locationName = "Unknown Location"
        coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        timeZone = TimeZone.current
        localTime = Date()
        isLoading = false
        errorMessage = nil
        lastUpdated = nil
    }
    
    // MARK: - Computed Properties
    
    /// Temperature formatted as string
    var temperatureString: String {
        return "\(Int(temperature))°C"
    }
    
    /// Wind speed formatted as string
    var windSpeedString: String {
        return "\(Int(windSpeed)) km/h"
    }
    
    /// Formatted date string
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: localTime)
    }
    
    /// Weather description for accessibility
    var accessibilityDescription: String {
        return "\(condition), \(temperatureString), wind \(windSpeedString), in \(locationName)"
    }
    
    // MARK: - Weather Condition Analysis
    
    /// Determines the primary weather vibe based on current conditions
    var primaryWeatherVibe: WeatherVibe {
        let lowercaseCondition = condition.lowercased()
        
        // Check for specific conditions first
        if lowercaseCondition.contains("rain") || lowercaseCondition.contains("drizzle") {
            return .rainy
        } else if lowercaseCondition.contains("snow") || lowercaseCondition.contains("flurr") {
            return .snowy
        } else if lowercaseCondition.contains("storm") || lowercaseCondition.contains("thunder") {
            return .stormy
        } else if lowercaseCondition.contains("fog") {
            return .foggy
        } else if lowercaseCondition.contains("haze") || lowercaseCondition.contains("mist") {
            return .misty
        } else if lowercaseCondition.contains("cloud") {
            return .cloudy
        } else if windSpeed > 20 {
            return .breezy
        } else {
            return .sunny
        }
    }
    
    /// Gets visual elements that should be rendered based on current weather
    var weatherVisualElements: [WeatherVisualElement] {
        var elements: [WeatherVisualElement] = []
        
        // Always add sky and terrain
        elements.append(.sky(intensity: 1.0))
        elements.append(.terrain)
        
        // Add condition-specific elements
        switch primaryWeatherVibe {
        case .rainy:
            elements.append(.clouds(density: 0.8, movement: 0.3))
            elements.append(.rain(intensity: 0.7, windEffect: windSpeed / 50.0))
            
        case .stormy:
            elements.append(.clouds(density: 0.9, movement: 0.6))
            elements.append(.rain(intensity: 0.9, windEffect: windSpeed / 30.0))
            elements.append(.lightning(frequency: 0.3))
            
        case .snowy:
            elements.append(.clouds(density: 0.7, movement: 0.2))
            elements.append(.snow(intensity: 0.6, windEffect: windSpeed / 40.0))
            
        case .foggy, .misty:
            elements.append(.fog(density: 0.7))
            elements.append(.clouds(density: 0.4, movement: 0.1))
            
        case .cloudy:
            elements.append(.clouds(density: cloudCoverage / 100.0, movement: 0.2))
            
        case .breezy:
            elements.append(.clouds(density: 0.3, movement: 0.5))
            elements.append(.particles(type: .leaves, count: Int(windSpeed * 2)))
            
        case .sunny:
            elements.append(.clouds(density: 0.1, movement: 0.1))
        }
        
        return elements
    }
}

/// Defines the visual elements that can be rendered in the immersive space
enum WeatherVisualElement {
    case sky(intensity: Double)
    case terrain
    case clouds(density: Double, movement: Double)
    case rain(intensity: Double, windEffect: Double)
    case snow(intensity: Double, windEffect: Double)
    case lightning(frequency: Double)
    case fog(density: Double)
    case particles(type: ParticleType, count: Int)
    
    enum ParticleType {
        case raindrops, snowflakes, dust, leaves
    }
}
