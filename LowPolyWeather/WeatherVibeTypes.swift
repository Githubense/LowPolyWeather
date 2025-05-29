//
//  WeatherVibeTypes.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation

/// Predefined weather vibes for relaxation mode
enum WeatherVibe: String, CaseIterable, Identifiable {
    case rainy = "rainy"
    case stormy = "stormy" 
    case snowy = "snowy"
    case breezy = "breezy"
    case sunny = "sunny"
    case misty = "misty"
    case foggy = "foggy"
    case cloudy = "cloudy"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .rainy: return "Rainy"
        case .stormy: return "Stormy"
        case .snowy: return "Snowy"
        case .breezy: return "Breezy"
        case .sunny: return "Sunny"
        case .misty: return "Misty"
        case .foggy: return "Foggy"
        case .cloudy: return "Cloudy"
        }
    }
    
    var description: String {
        switch self {
        case .rainy: return "Gentle rain sounds for deep relaxation"
        case .stormy: return "Thunder and heavy rain for intense atmosphere"
        case .snowy: return "Peaceful snowfall in winter wonderland"
        case .breezy: return "Light winds and clear skies"
        case .sunny: return "Bright sunshine with birds chirping"
        case .misty: return "Soft mist and gentle humidity"
        case .foggy: return "Dense fog with muffled sounds"
        case .cloudy: return "Overcast skies with soft lighting"
        }
    }
    
    var emoji: String {
        switch self {
        case .rainy: return "🌧️"
        case .stormy: return "⛈️"
        case .snowy: return "❄️"
        case .breezy: return "🌬️"
        case .sunny: return "☀️"
        case .misty: return "🌫️"
        case .foggy: return "🌁"
        case .cloudy: return "☁️"
        }
    }
    
    /// Maps weather vibe to WeatherKit conditions for searching
    var matchingConditions: [WeatherCondition] {
        switch self {
        case .rainy:
            return [.rain, .drizzle, .sunShowers]
        case .stormy:
            return [.thunderstorms, .strongStorms, .heavyRain, .isolatedThunderstorms, .scatteredThunderstorms]
        case .snowy:
            return [.snow, .heavySnow, .flurries, .sunFlurries, .wintryMix]
        case .breezy:
            return [.breezy, .windy, .clear, .mostlyClear]
        case .sunny:
            return [.clear, .mostlyClear]
        case .misty:
            return [.haze, .foggy]
        case .foggy:
            return [.foggy, .haze, .smoky]
        case .cloudy:
            return [.cloudy, .mostlyCloudy, .partlyCloudy]
        }
    }
}

/// Global locations database for weather searching
struct GlobalWeatherLocation {
    let name: String
    let coordinate: CLLocationCoordinate2D
    let timeZoneIdentifier: String
    let country: String
    let priority: Int // 1-10, higher = more likely to have the desired weather
    
    var timeZone: TimeZone? {
        return TimeZone(identifier: timeZoneIdentifier)
    }
    
    var location: CLLocation {
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

/// Database of major world cities for weather vibe searching
class GlobalWeatherDatabase {
    static let shared = GlobalWeatherDatabase()
    
    private let locations: [GlobalWeatherLocation] = [
        // North America
        GlobalWeatherLocation(name: "New York", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), timeZoneIdentifier: "America/New_York", country: "United States", priority: 5),
        GlobalWeatherLocation(name: "Los Angeles", coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
        GlobalWeatherLocation(name: "Chicago", coordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 5),
        GlobalWeatherLocation(name: "Vancouver", coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207), timeZoneIdentifier: "America/Vancouver", country: "Canada", priority: 5),
        GlobalWeatherLocation(name: "Mexico City", coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), timeZoneIdentifier: "America/Mexico_City", country: "Mexico", priority: 5),
        
        // Europe
        GlobalWeatherLocation(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
        GlobalWeatherLocation(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), timeZoneIdentifier: "Europe/Paris", country: "France", priority: 5),
        GlobalWeatherLocation(name: "Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050), timeZoneIdentifier: "Europe/Berlin", country: "Germany", priority: 5),
        GlobalWeatherLocation(name: "Amsterdam", coordinate: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), timeZoneIdentifier: "Europe/Amsterdam", country: "Netherlands", priority: 5),
        GlobalWeatherLocation(name: "Stockholm", coordinate: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 5),
        
        // Asia
        GlobalWeatherLocation(name: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.6762, longitude: 139.6503), timeZoneIdentifier: "Asia/Tokyo", country: "Japan", priority: 5),
        GlobalWeatherLocation(name: "Seoul", coordinate: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), timeZoneIdentifier: "Asia/Seoul", country: "South Korea", priority: 5),
        GlobalWeatherLocation(name: "Beijing", coordinate: CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074), timeZoneIdentifier: "Asia/Shanghai", country: "China", priority: 5),
        GlobalWeatherLocation(name: "Mumbai", coordinate: CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777), timeZoneIdentifier: "Asia/Kolkata", country: "India", priority: 5),
        GlobalWeatherLocation(name: "Bangkok", coordinate: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018), timeZoneIdentifier: "Asia/Bangkok", country: "Thailand", priority: 5),
        GlobalWeatherLocation(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), timeZoneIdentifier: "Asia/Singapore", country: "Singapore", priority: 5),
        
        // Oceania
        GlobalWeatherLocation(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093), timeZoneIdentifier: "Australia/Sydney", country: "Australia", priority: 5),
        GlobalWeatherLocation(name: "Melbourne", coordinate: CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631), timeZoneIdentifier: "Australia/Melbourne", country: "Australia", priority: 5),
        GlobalWeatherLocation(name: "Auckland", coordinate: CLLocationCoordinate2D(latitude: -36.8485, longitude: 174.7633), timeZoneIdentifier: "Pacific/Auckland", country: "New Zealand", priority: 5),
        
        // South America
        GlobalWeatherLocation(name: "São Paulo", coordinate: CLLocationCoordinate2D(latitude: -23.5505, longitude: -46.6333), timeZoneIdentifier: "America/Sao_Paulo", country: "Brazil", priority: 5),
        GlobalWeatherLocation(name: "Buenos Aires", coordinate: CLLocationCoordinate2D(latitude: -34.6118, longitude: -58.3960), timeZoneIdentifier: "America/Argentina/Buenos_Aires", country: "Argentina", priority: 5),
        GlobalWeatherLocation(name: "Lima", coordinate: CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428), timeZoneIdentifier: "America/Lima", country: "Peru", priority: 5),
        
        // Africa
        GlobalWeatherLocation(name: "Cairo", coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), timeZoneIdentifier: "Africa/Cairo", country: "Egypt", priority: 5),
        GlobalWeatherLocation(name: "Cape Town", coordinate: CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241), timeZoneIdentifier: "Africa/Johannesburg", country: "South Africa", priority: 5),
        GlobalWeatherLocation(name: "Lagos", coordinate: CLLocationCoordinate2D(latitude: 6.5244, longitude: 3.3792), timeZoneIdentifier: "Africa/Lagos", country: "Nigeria", priority: 5)
    ]
    
    /// Returns all available locations for weather searching
    var allLocations: [GlobalWeatherLocation] {
        return locations
    }
    
    /// Returns locations shuffled for random sampling
    var shuffledLocations: [GlobalWeatherLocation] {
        return locations.shuffled()
    }
}