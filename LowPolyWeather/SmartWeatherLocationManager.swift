//
//  SmartWeatherLocationManager.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation

/// Manages intelligent weather location selection with comprehensive fallback search
@MainActor
class SmartWeatherLocationManager: ObservableObject {
    static let shared = SmartWeatherLocationManager()
    
    /// Simple prefetch system
    private let prefetch = SimpleWeatherPrefetch.shared
    
    /// Enhanced weather database
    private let database = EnhancedGlobalWeatherDatabase.shared
    
    /// Global fallback locations
    private let fallbackDatabase = GlobalFallbackLocations.shared
    
    /// Track used locations to avoid repeats
    private var usedLocations: Set<String> = []
    
    private init() {
        print("🔧 Initializing SmartWeatherLocationManager with comprehensive dataset...")
        
        // Start background prefetch after initialization
        Task {
            // Small delay to let the app finish launching
            try? await Task.sleep(for: .seconds(2))
            prefetch.startBackgroundPrefetch()
        }
    }
    
    // MARK: - Public Methods
    
    /// Gets preferred locations for a specific vibe (primary tier only)
    func getPreferredLocations(for vibe: WeatherVibe) -> [GlobalWeatherLocation] {
        return database.getLocations(for: vibe, tier: .primary)
    }
    
    /// Resets used locations to allow fresh searches
    func resetUsedLocations() {
        usedLocations.removeAll()
        print("🔄 Reset used locations - fresh search possible")
    }
    
    /// Comprehensive search with multi-tier fallback + global fallback - STOPS when weather is found
    func searchForFirstPerfectMatch(_ vibe: WeatherVibe) async throws -> VibeSearchResult? {
        print("🎯 Smart search for FIRST PERFECT \(vibe.displayName) weather match with comprehensive fallback...")
        print("📍 Previously used locations: \(usedLocations.count)")
        
        // STOP PREFETCHING when starting targeted search
        print("🛑 Stopping background prefetch to focus on \(vibe.displayName) search...")
        prefetch.stopBackgroundPrefetch()
        
        // Phase 1: Search priority tiers (primary, secondary)
        print("🔍 Phase 1: Searching priority tiers...")
        if let result = try await searchPriorityTiers(for: vibe) {
            return result
        }
        
        // Phase 2: Search global fallback locations
        print("🔍 Phase 2: No matches in priority tiers, searching global fallback locations...")
        if let result = try await searchFallbackLocations(for: vibe) {
            return result
        }
        
        print("   😞 No perfect matches found in ANY location database for \(vibe.displayName)")
        print("   🔄 Resetting used locations for next search...")
        resetUsedLocations()
        return nil
    }
    
    // MARK: - Private Search Methods
    
    /// Searches through priority tiers (primary, secondary)
    private func searchPriorityTiers(for vibe: WeatherVibe) async throws -> VibeSearchResult? {
        // Search through each tier until we find a match
        let tiers: [EnhancedGlobalWeatherDatabase.LocationTier] = [.primary, .secondary]
        
        for tier in tiers {
            let tierName = tier == .primary ? "Primary" : "Secondary"
            print("   🔍 Searching \(tierName.lowercased()) locations for \(vibe.displayName)...")
            
            let locations = database.getLocations(for: vibe, tier: tier)
            let sortedLocations = locations.sorted { $0.priority > $1.priority }
            
            // Filter out used locations
            let unusedLocations = sortedLocations.filter { location in
                let locationKey = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                return !usedLocations.contains(locationKey)
            }
            
            print("   📊 Available unused locations in \(tierName): \(unusedLocations.count)/\(sortedLocations.count)")
            
            for location in unusedLocations {
                if let result = try await checkLocationForMatch(location, vibe: vibe) {
                    print("   🚀 STOPPING PRIORITY SEARCH - PERFECT MATCH READY!")
                    return result
                }
            }
            
            print("   😔 No matches found in \(tierName.lowercased()) locations")
        }
        
        return nil
    }
    
    /// Searches through global fallback locations
    private func searchFallbackLocations(for vibe: WeatherVibe) async throws -> VibeSearchResult? {
        print("   🌍 Searching global fallback locations for \(vibe.displayName)...")
        
        let fallbackLocations = fallbackDatabase.fallbackLocations[vibe] ?? []
        let sortedLocations = fallbackLocations.sorted { $0.priority > $1.priority }
        
        // Filter out used locations
        let unusedLocations = sortedLocations.filter { location in
            let locationKey = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            return !usedLocations.contains(locationKey)
        }
        
        print("   📊 Available unused fallback locations: \(unusedLocations.count)/\(sortedLocations.count)")
        
        for location in unusedLocations {
            if let result = try await checkLocationForMatch(location, vibe: vibe) {
                print("   🎯 FALLBACK MATCH FOUND: \(location.name) - \(result.weather.condition.description) (score: \(result.matchScore))")
                print("   🚀 STOPPING FALLBACK SEARCH - PERFECT MATCH READY!")
                return result
            }
        }
        
        print("   😔 No matches found in fallback locations")
        return nil
    }
    
    /// Checks a single location for weather match
    private func checkLocationForMatch(_ location: GlobalWeatherLocation, vibe: WeatherVibe) async throws -> VibeSearchResult? {
        do {
            // Mark this location as used
            let locationKey = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            usedLocations.insert(locationKey)
            
            var weather: CurrentWeather
            
            // First check cache
            if let cachedWeather = prefetch.getCachedWeather(for: location) {
                print("   💾 Using cached weather for \(location.name)")
                weather = cachedWeather
            } else {
                print("   🔍 Fetching REAL weather for \(location.name)...")
                let (fetchedWeather, _) = try await WeatherService.shared.fetchWeather(for: location.location)
                weather = fetchedWeather
                
                // Cache the result for future use
                prefetch.cacheWeather(weather, for: location)
            }
            
            print("   🌤️ Current condition: \(weather.condition.description)")
            print("   🌡️ Temperature: \(Int(weather.temperature.converted(to: .celsius).value))°C")
            print("   💨 Wind: \(Int(weather.wind.speed.converted(to: .kilometersPerHour).value)) km/h")
            print("   ⏰ Weather time: \(weather.date)")
            
            // Check if this weather matches the vibe with STRICT matching
            if isStrictWeatherMatch(weather, vibe: vibe) {
                let matchScore = calculateMatchScore(weather: weather, for: vibe)
                let result = VibeSearchResult(
                    location: location,
                    weather: weather,
                    matchScore: matchScore
                )
                
                print("   🎯 PERFECT MATCH FOUND: \(location.name) - \(weather.condition.description) (score: \(result.matchScore))")
                return result
            } else {
                print("   ❌ No match: \(location.name) - \(weather.condition.description) doesn't match \(vibe.displayName)")
            }
            
            // Faster rate limiting for targeted search (reduced from 1 second to 0.5 seconds)
            if prefetch.getCachedWeather(for: location) == nil {
                try? await Task.sleep(for: .milliseconds(500))
            }
            
        } catch {
            print("   ⚠️ Failed to get weather for \(location.name): \(error.localizedDescription)")
        }
        
        return nil
    }
    
    // MARK: - Weather Matching Logic
    
    /// Checks if weather matches a vibe with STRICT criteria
    func isStrictWeatherMatch(_ weather: CurrentWeather, vibe: WeatherVibe) -> Bool {
        let temp = weather.temperature.converted(to: .celsius).value
        let condition = weather.condition
        let windSpeed = weather.wind.speed.converted(to: .kilometersPerHour).value
        
        switch vibe {
        case .rainy:
            return isRainyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .sunny:
            return isSunnyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .stormy:
            return isStormyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .snowy:
            return isSnowyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .breezy:
            return isBreezyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .misty:
            return isMistyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .foggy:
            return isFoggyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        case .cloudy:
            return isCloudyWeather(temp: temp, condition: condition, windSpeed: windSpeed)
        }
    }
    
    /// Calculates match score for weather and vibe
    func calculateMatchScore(weather: CurrentWeather, for vibe: WeatherVibe) -> Double {
        let temp = weather.temperature.converted(to: .celsius).value
        let condition = weather.condition
        let windSpeed = weather.wind.speed.converted(to: .kilometersPerHour).value
        
        var score: Double = 0
        
        switch vibe {
        case .rainy:
            score += rainyTemperatureScore(temp)
            score += rainyConditionScore(condition)
            score += rainyWindScore(windSpeed)
            
        case .sunny:
            score += sunnyTemperatureScore(temp)
            score += sunnyConditionScore(condition)
            score += sunnyWindScore(windSpeed)
            
        case .stormy:
            score += stormyTemperatureScore(temp)
            score += stormyConditionScore(condition)
            score += stormyWindScore(windSpeed)
            
        case .snowy:
            score += snowyTemperatureScore(temp)
            score += snowyConditionScore(condition)
            score += snowyWindScore(windSpeed)
            
        case .breezy:
            score += breezyTemperatureScore(temp)
            score += breezyConditionScore(condition)
            score += breezyWindScore(windSpeed)
            
        case .misty:
            score += mistyTemperatureScore(temp)
            score += mistyConditionScore(condition)
            score += mistyWindScore(windSpeed)
            
        case .foggy:
            score += foggyTemperatureScore(temp)
            score += foggyConditionScore(condition)
            score += foggyWindScore(windSpeed)
            
        case .cloudy:
            score += cloudyTemperatureScore(temp)
            score += cloudyConditionScore(condition)
            score += cloudyWindScore(windSpeed)
        }
        
        return min(score, 100) // Cap at 100
    }
    
    // MARK: - Private Weather Matching Methods
    
    private func isRainyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 8...25 // 8-25°C
        let goodConditions: [WeatherCondition] = [.drizzle, .rain, .heavyRain, .sunShowers]
        let maxWind = 30.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed <= maxWind
    }
    
    private func isSunnyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 18...35 // 18-35°C
        let goodConditions: [WeatherCondition] = [.clear, .mostlyClear, .partlyCloudy]
        let maxWind = 20.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed <= maxWind
    }
    
    private func isStormyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        // FIXED: Simplified stormy weather matching - removed unused variable
        let minWind = 25.0 // km/h - increased from 15 to be more strict
        
        // For heavy rain, require high wind too
        if condition == .heavyRain {
            return windSpeed >= minWind
        }
        
        // For actual storms, condition is enough
        if [.thunderstorms, .strongStorms, .isolatedThunderstorms, .scatteredThunderstorms].contains(condition) {
            return true
        }
        
        // Otherwise, no match
        return false
    }
    
    private func isSnowyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = -15...5 // -15 to 5°C
        let snowyConditions: [WeatherCondition] = [.snow, .heavySnow, .blizzard, .flurries, .sunFlurries, .wintryMix]
        
        return tempRange.contains(Int(temp)) && snowyConditions.contains(condition)
    }
    
    private func isBreezyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 10...28 // 10-28°C
        let goodConditions: [WeatherCondition] = [.clear, .mostlyClear, .partlyCloudy, .breezy, .windy]
        let minWind = 15.0 // km/h
        let maxWind = 40.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed >= minWind && windSpeed <= maxWind
    }
    
    private func isMistyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 5...20 // 5-20°C
        let goodConditions: [WeatherCondition] = [.haze, .foggy, .mostlyCloudy, .cloudy]
        let maxWind = 15.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed <= maxWind
    }
    
    private func isFoggyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 0...18 // 0-18°C
        let goodConditions: [WeatherCondition] = [.foggy, .haze, .smoky]
        let maxWind = 10.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed <= maxWind
    }
    
    private func isCloudyWeather(temp: Double, condition: WeatherCondition, windSpeed: Double) -> Bool {
        let tempRange = 5...25 // 5-25°C
        let goodConditions: [WeatherCondition] = [.cloudy, .mostlyCloudy, .partlyCloudy]
        let maxWind = 25.0 // km/h
        
        return tempRange.contains(Int(temp)) && goodConditions.contains(condition) && windSpeed <= maxWind
    }

    // MARK: - Scoring Methods
    
    private func rainyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 15.0 // 15°C is ideal rainy temperature
        let difference = abs(temp - ideal)
        return max(0, 35 - (difference * 2))
    }
    
    private func rainyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .rain: return 40
        case .drizzle: return 35
        case .heavyRain: return 30
        case .sunShowers: return 25
        default: return 0
        }
    }
    
    private func rainyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 15 { return 25 }
        if windSpeed <= 25 { return 20 }
        return 0
    }
    
    private func sunnyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 25.0 // 25°C is ideal sunny temperature
        let difference = abs(temp - ideal)
        return max(0, 40 - (difference * 1.5))
    }
    
    private func sunnyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .clear: return 40
        case .mostlyClear: return 35
        case .partlyCloudy: return 25
        default: return 0
        }
    }
    
    private func sunnyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 10 { return 20 }
        if windSpeed <= 20 { return 15 }
        return 0
    }
    
    private func stormyTemperatureScore(_ temp: Double) -> Double {
        return 15 // Temperature less important for storms, reduced from 20
    }
    
    private func stormyConditionScore(_ condition: WeatherCondition) -> Double {
        // FIXED: Only award points for actual storm conditions
        switch condition {
        case .thunderstorms, .strongStorms: return 60
        case .isolatedThunderstorms, .scatteredThunderstorms: return 55
        case .heavyRain: return 30 // Only if combined with high wind
        default: return 0 // NO points for non-stormy conditions
        }
    }
    
    private func stormyWindScore(_ windSpeed: Double) -> Double {
        // FIXED: Higher requirements for stormy wind
        if windSpeed >= 50 { return 25 }
        if windSpeed >= 35 { return 20 }
        if windSpeed >= 25 { return 15 }
        return 0
    }
    
    private func snowyTemperatureScore(_ temp: Double) -> Double {
        if temp <= -5 { return 40 }
        if temp <= 0 { return 35 }
        if temp <= 3 { return 25 }
        return 0
    }
    
    private func snowyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .snow: return 40
        case .heavySnow, .blizzard: return 50
        case .flurries, .sunFlurries: return 30
        case .wintryMix: return 25
        default: return 0
        }
    }
    
    private func snowyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 20 { return 10 }
        return 5
    }
    
    private func breezyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 20.0
        let difference = abs(temp - ideal)
        return max(0, 30 - difference)
    }
    
    private func breezyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .breezy, .windy: return 40
        case .clear, .mostlyClear: return 30
        case .partlyCloudy: return 25
        default: return 0
        }
    }
    
    private func breezyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed >= 20 && windSpeed <= 35 { return 30 }
        if windSpeed >= 15 && windSpeed <= 40 { return 25 }
        return 0
    }
    
    private func mistyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 12.0
        let difference = abs(temp - ideal)
        return max(0, 30 - (difference * 2))
    }
    
    private func mistyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .haze: return 40
        case .foggy: return 35
        case .mostlyCloudy: return 30
        default: return 0
        }
    }
    
    private func mistyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 10 { return 30 }
        if windSpeed <= 15 { return 20 }
        return 0
    }
    
    private func foggyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 8.0
        let difference = abs(temp - ideal)
        return max(0, 30 - (difference * 2))
    }
    
    private func foggyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .foggy: return 50
        case .haze: return 35
        case .smoky: return 30
        default: return 0
        }
    }
    
    private func foggyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 5 { return 20 }
        if windSpeed <= 10 { return 15 }
        return 0
    }
    
    private func cloudyTemperatureScore(_ temp: Double) -> Double {
        let ideal = 16.0
        let difference = abs(temp - ideal)
        return max(0, 30 - difference)
    }
    
    private func cloudyConditionScore(_ condition: WeatherCondition) -> Double {
        switch condition {
        case .cloudy: return 40
        case .mostlyCloudy: return 35
        case .partlyCloudy: return 25
        default: return 0
        }
    }
    
    private func cloudyWindScore(_ windSpeed: Double) -> Double {
        if windSpeed <= 20 { return 30 }
        if windSpeed <= 25 { return 20 }
        return 0
    }
}

// MARK: - VibeSearchResult (for REAL weather data)

struct VibeSearchResult: Identifiable {
    let id = UUID()
    let location: GlobalWeatherLocation
    let weather: CurrentWeather // This is REAL weather data from WeatherKit
    let matchScore: Double
    
    var temperatureDisplay: String {
        let temp = Int(weather.temperature.converted(to: .celsius).value)
        return "\(temp)°C"
    }
    
    var localTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = location.timeZone
        formatter.timeStyle = .short
        return formatter.string(from: weather.date) // Using REAL weather timestamp
    }
    
    var conditionDisplay: String {
        return weather.condition.description // REAL weather condition
    }
}