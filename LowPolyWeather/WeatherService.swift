//
//  WeatherService.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor
class WeatherService: NSObject, ObservableObject {
    static let shared = WeatherService()
    
    private let weatherService = WeatherKit.WeatherService.shared
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    /// Requests location permission and starts location updates
    func requestLocationPermission() {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            // Handle denied case - maybe show alert to user
            print("Location access denied")
        case .authorizedWhenInUse:
            startLocationUpdates()
        @unknown default:
            break
        }
    }
    
    /// Starts location updates
    private func startLocationUpdates() {
        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
    }
    
    /// Fetches current weather for user's location
    func fetchCurrentWeather() async throws -> (CurrentWeather, CLLocation?, CLPlacemark?) {
        guard let location = currentLocation else {
            throw WeatherError.locationNotAvailable
        }
        
        let weather = try await weatherService.weather(for: location)
        let placemark = try? await geocoder.reverseGeocodeLocation(location).first
        
        return (weather.currentWeather, location, placemark)
    }
    
    /// Fetches weather for a specific location (for "Find My Vibe" mode)
    func fetchWeather(for location: CLLocation) async throws -> (CurrentWeather, CLPlacemark?) {
        let weather = try await weatherService.weather(for: location)
        let placemark = try? await geocoder.reverseGeocodeLocation(location).first
        
        return (weather.currentWeather, placemark)
    }
    
    /// Searches for locations with specific weather conditions (placeholder for future implementation)
    func findLocationWithWeather(condition: WeatherCondition) async throws -> CLLocation {
        // This is a placeholder - in a real implementation, you might:
        // 1. Query a database of world cities
        // 2. Check weather for multiple locations
        // 3. Return the first match
        
        // For now, return a random major city
        let majorCities: [CLLocation] = [
            CLLocation(latitude: 40.7128, longitude: -74.0060), // New York
            CLLocation(latitude: 51.5074, longitude: -0.1278),  // London
            CLLocation(latitude: 35.6762, longitude: 139.6503), // Tokyo
            CLLocation(latitude: -33.8688, longitude: 151.2093), // Sydney
            CLLocation(latitude: 48.8566, longitude: 2.3522),   // Paris
        ]
        
        return majorCities.randomElement() ?? majorCities[0]
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherService: CLLocationManagerDelegate {
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            currentLocation = locations.last
            locationManager.stopUpdatingLocation()
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            authorizationStatus = manager.authorizationStatus
            
            switch authorizationStatus {
            case .authorizedWhenInUse:
                startLocationUpdates()
            default:
                break
            }
        }
    }
}

// MARK: - Error Types

enum WeatherError: LocalizedError {
    case locationNotAvailable
    case weatherDataUnavailable
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .locationNotAvailable:
            return "Location not available. Please enable location services."
        case .weatherDataUnavailable:
            return "Weather data is currently unavailable."
        case .networkError:
            return "Network connection error. Please try again."
        }
    }
}