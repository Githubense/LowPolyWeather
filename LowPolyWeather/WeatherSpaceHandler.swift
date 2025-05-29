//
//  WeatherSpaceHandler.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation
import SwiftUI

@MainActor
@Observable
class WeatherSpaceHandler {
    
    // MARK: - Properties
    
    /// Current weather data for the immersive space
    var weatherData = WeatherData()
    
    /// Current operation mode
    var spaceMode: WeatherSpaceMode = .currentLocation
    
    /// Selected weather vibe for relaxation mode
    var selectedVibe: WeatherVibe?
    
    /// Loading states
    var isSearchingForVibe = false
    var isLoadingCurrentWeather = false
    
    /// Vibe search results from real weather data
    var vibeSearchResults: [VibeSearchResult] = []
    
    /// Flag to indicate when a perfect match is found and ready for immersive space
    var isPerfectMatchFound = false
    
    /// Flag to indicate if valid weather data is loaded
    var hasValidWeatherData = false
    
    /// Services
    private let weatherService = WeatherService.shared
    private let smartLocationManager = SmartWeatherLocationManager.shared
    
    /// Simple prefetch system
    private let prefetch = SimpleWeatherPrefetch.shared
    
    // MARK: - Mode Definition
    
    enum WeatherSpaceMode {
        case currentLocation
        case findVibe
    }
    
    init() {
        print("🔧 Initializing WeatherSpaceHandler...")
        print("✅ WeatherSpaceHandler initialized for real-time weather data")
    }
    
    // MARK: - Public Methods
    
    /// Validates if weather data is ready for immersive space
    var isWeatherDataValid: Bool {
        return hasValidWeatherData && 
               weatherData.locationName != "Unknown Location" && 
               !weatherData.locationName.isEmpty &&
               weatherData.errorMessage == nil
    }
    
    /// Switches to current location mode and loads weather with cache support
    func loadCurrentLocationWeather() async {
        print("🏠 Loading current location weather...")
        
        spaceMode = .currentLocation
        selectedVibe = nil
        vibeSearchResults = []
        isPerfectMatchFound = false
        hasValidWeatherData = false
        
        // Reset used locations for fresh searches
        smartLocationManager.resetUsedLocations()
        
        isLoadingCurrentWeather = true
        weatherData.isLoading = true
        weatherData.errorMessage = nil
        
        do {
            var currentWeather: CurrentWeather
            var location: CLLocation?
            var placemark: CLPlacemark?
            
            // First check cache
            if let cachedWeather = prefetch.getCachedCurrentLocationWeather() {
                print("💾 Using cached current location weather")
                currentWeather = cachedWeather
                location = weatherService.currentLocation
                placemark = nil
            } else {
                print("🔍 Fetching REAL current location weather...")
                let (fetchedWeather, fetchedLocation, fetchedPlacemark) = try await weatherService.fetchCurrentWeather()
                currentWeather = fetchedWeather
                location = fetchedLocation
                placemark = fetchedPlacemark
                
                // Cache the result
                prefetch.cacheCurrentLocationWeather(currentWeather)
            }
            
            // VALIDATION: Ensure we have valid location data
            guard let validLocation = location else {
                throw WeatherError.locationNotAvailable
            }
            
            // Update weather data with REAL data
            print("📊 Updating with REAL current location weather data:")
            print("   🌤️ Condition: \(currentWeather.condition.description)")
            print("   🌡️ Temperature: \(currentWeather.temperature.converted(to: .celsius).value)°C")
            print("   ⏰ Weather timestamp: \(currentWeather.date)")
            
            weatherData.update(from: currentWeather, location: validLocation, placemark: placemark)
            
            // VALIDATION: Ensure location name is properly set
            if let placemark = placemark {
                let locationName = placemark.locality ?? placemark.administrativeArea ?? placemark.country ?? nil
                if let validLocationName = locationName, !validLocationName.isEmpty {
                    weatherData.locationName = validLocationName
                    hasValidWeatherData = true
                    print("   🏠 Location name set to: \(weatherData.locationName)")
                } else {
                    throw WeatherError.locationNotAvailable
                }
            } else {
                // If no placemark, use coordinates as fallback
                weatherData.locationName = "Current Location"
                hasValidWeatherData = true
                print("   🏠 Location name set to: Current Location (fallback)")
            }
            
            print("✅ REAL current location weather data update completed successfully")
            print("✅ Valid weather data loaded: \(hasValidWeatherData)")
            
        } catch {
            let errorMessage = "Failed to load current weather: \(error.localizedDescription)"
            weatherData.errorMessage = errorMessage
            hasValidWeatherData = false
            weatherData.locationName = "Unknown Location"
            print("❌ Failed to load current weather: \(errorMessage)")
            print("❌ Valid weather data: \(hasValidWeatherData)")
        }
        
        isLoadingCurrentWeather = false
        weatherData.isLoading = false
        print("🏁 Current location weather loading completed")
    }
    
    /// Switches to vibe mode and searches for matching weather with comprehensive fallback
    func findVibeWeather(for vibe: WeatherVibe) async {
        print("🎭 Finding weather for \(vibe.displayName) vibe with comprehensive fallback search...")
        
        spaceMode = .findVibe
        selectedVibe = vibe
        vibeSearchResults = []
        isPerfectMatchFound = false
        hasValidWeatherData = false
        
        // Reset used locations for fresh search
        smartLocationManager.resetUsedLocations()
        
        isSearchingForVibe = true
        weatherData.isLoading = true
        weatherData.errorMessage = nil
        
        do {
            print("🔍 Searching for \(vibe.displayName) weather using comprehensive multi-tier + fallback search...")
            let searchResult = try await smartLocationManager.searchForFirstPerfectMatch(vibe)
            
            if let result = searchResult {
                print("🎯 COMPREHENSIVE MATCH FOUND: \(result.location.name)")
                print("🌤️ Weather: \(result.weather.condition.description)")
                print("🌡️ Temperature: \(Int(result.weather.temperature.converted(to: .celsius).value))°C")
                print("💨 Wind: \(Int(result.weather.wind.speed.converted(to: .kilometersPerHour).value)) km/h")
                print("⭐ Match score: \(result.matchScore)")
                
                // VALIDATION: Ensure we have a valid location name
                guard !result.location.name.isEmpty && 
                      result.location.name != "Unknown Location" else {
                    throw WeatherError.locationNotAvailable
                }
                
                vibeSearchResults = [result]
                
                // Convert CLLocation to location for weatherData and PROPERLY SET LOCATION NAME
                let clLocation = result.location.location
                weatherData.update(from: result.weather, location: clLocation, placemark: nil)
                
                // FIXED: Properly set location name from the result with validation
                weatherData.locationName = result.location.name
                hasValidWeatherData = true
                
                // FIXED: Set the correct timezone for the location
                if let timeZone = result.location.timeZone {
                    weatherData.timeZone = timeZone
                }
                
                isPerfectMatchFound = true
                
                print("📊 Updating with REAL weather data:")
                print("   🌤️ Condition: \(result.weather.condition.description)")
                print("   🌡️ Temperature: \(result.weather.temperature.converted(to: .celsius).value)°C")
                print("   ⏰ Weather timestamp: \(result.weather.date)")
                print("   🌍 Location name: \(weatherData.locationName)")
                print("   🌍 Coordinates: \(result.location.coordinate.latitude), \(result.location.coordinate.longitude)")
                print("✅ REAL weather data update completed successfully")
                print("✅ Valid weather data loaded: \(hasValidWeatherData)")
                
                print("✅ Perfect weather match loaded successfully")
            } else {
                // If still no match found, trigger additional fallback prefetch for this specific vibe
                print("🌍 No matches found in all databases, triggering targeted fallback search...")
                await prefetch.startFallbackPrefetch(for: vibe)
                
                // Try one more search after fallback prefetch
                let secondSearchResult = try await smartLocationManager.searchForFirstPerfectMatch(vibe)
                
                if let result = secondSearchResult {
                    print("🎯 FALLBACK SEARCH SUCCESS: \(result.location.name)")
                    
                    // VALIDATION: Ensure we have a valid location name
                    guard !result.location.name.isEmpty && 
                          result.location.name != "Unknown Location" else {
                        throw WeatherError.locationNotAvailable
                    }
                    
                    vibeSearchResults = [result]
                    let clLocation = result.location.location
                    weatherData.update(from: result.weather, location: clLocation, placemark: nil)
                    
                    // FIXED: Properly set location name from the fallback result with validation
                    weatherData.locationName = result.location.name
                    hasValidWeatherData = true
                    
                    // FIXED: Set the correct timezone for the location
                    if let timeZone = result.location.timeZone {
                        weatherData.timeZone = timeZone
                    }
                    
                    isPerfectMatchFound = true
                    print("✅ Fallback weather match loaded successfully")
                    print("✅ Valid weather data loaded: \(hasValidWeatherData)")
                } else {
                    // NO VALID WEATHER FOUND - DO NOT LOAD ANYTHING
                    let errorMessage = "No perfect weather match found for \(vibe.displayName) across all global locations. This weather pattern may not be currently available worldwide. Please try a different vibe or try again later."
                    weatherData.errorMessage = errorMessage
                    isPerfectMatchFound = false
                    hasValidWeatherData = false
                    weatherData.locationName = "Unknown Location" // Keep as unknown to prevent loading
                    print("😔 \(errorMessage)")
                    print("❌ Valid weather data: \(hasValidWeatherData)")
                }
            }
            
        } catch {
            let errorMessage = "Failed to search for \(vibe.displayName) weather: \(error.localizedDescription)"
            weatherData.errorMessage = errorMessage
            isPerfectMatchFound = false
            hasValidWeatherData = false
            weatherData.locationName = "Unknown Location" // Keep as unknown to prevent loading
            print("❌ \(errorMessage)")
            print("❌ Valid weather data: \(hasValidWeatherData)")
        }
        
        isSearchingForVibe = false
        weatherData.isLoading = false
        print("🏁 Comprehensive vibe weather search completed. Match found: \(isPerfectMatchFound)")
        print("🏁 Valid weather data ready: \(hasValidWeatherData)")
    }
    
    /// Selects a specific vibe result and updates the weather data with REAL data
    func selectVibeResult(_ result: VibeSearchResult) async {
        print("🎯 Selecting vibe result: \(result.location.name)")
        print("🌤️ REAL weather: \(result.weather.condition.description)")
        print("🌡️ REAL temperature: \(result.temperatureDisplay)")
        print("⏰ REAL time: \(result.weather.date)")
        
        // VALIDATION: Ensure we have a valid location name
        guard !result.location.name.isEmpty && 
              result.location.name != "Unknown Location" else {
            print("❌ Invalid location name, cannot select result")
            return
        }
        
        weatherData.isLoading = true
        
        // Update weather data from the REAL weather result
        weatherData.update(from: result.weather, location: result.location.location, placemark: nil)
        
        // FIXED: Properly set location name with validation
        weatherData.locationName = result.location.name
        hasValidWeatherData = true
        
        // Set the correct timezone for the location
        if let timeZone = result.location.timeZone {
            weatherData.timeZone = timeZone
        }
        
        weatherData.isLoading = false
        print("✅ REAL weather data updated to \(result.location.name)")
        print("✅ Valid weather data: \(hasValidWeatherData)")
    }
    
    /// Refreshes current weather data
    func refreshCurrentWeather() async {
        print("🔄 Refreshing REAL weather data...")
        
        // Reset used locations for fresh search
        smartLocationManager.resetUsedLocations()
        
        switch spaceMode {
        case .currentLocation:
            print("🏠 Refreshing current location weather")
            await loadCurrentLocationWeather()
        case .findVibe:
            if let vibe = selectedVibe {
                print("🎭 Refreshing \(vibe.displayName) vibe weather")
                await findVibeWeather(for: vibe)
            } else {
                print("⚠️ No vibe selected for refresh")
            }
        }
    }
    
    // MARK: - Computed Properties
    
    var formattedLocalTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = weatherData.timeZone
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: weatherData.localTime)
    }
    
    var formattedLocalDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = weatherData.timeZone
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: weatherData.localTime)
    }
    
    var weatherSummary: String {
        return "\(weatherData.condition) • \(Int(weatherData.temperature))°C"
    }
}