//
//  SimpleWeatherPrefetch.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import WeatherKit
import CoreLocation

/// Simple weather prefetch system with comprehensive fallback support
@MainActor
@Observable
class SimpleWeatherPrefetch {
    static let shared = SimpleWeatherPrefetch()
    
    // MARK: - Cache
    
    /// Simple cache for weather data
    private var weatherCache: [String: CachedWeather] = [:]
    
    /// Cache expiry time (5 minutes)
    private let cacheExpirySeconds: TimeInterval = 300
    
    /// Background prefetch task
    private var prefetchTask: Task<Void, Never>?
    
    /// Fallback prefetch task
    private var fallbackPrefetchTask: Task<Void, Never>?
    
    /// Prefetch status
    private(set) var isPrefetching = false
    
    /// Enhanced weather database
    private let database = EnhancedGlobalWeatherDatabase.shared
    
    /// Global fallback locations
    private let fallbackDatabase = GlobalFallbackLocations.shared
    
    private init() {
        print("🔧 Initializing SimpleWeatherPrefetch with comprehensive fallback support...")
    }
    
    // MARK: - Public Methods
    
    /// Starts background prefetch for priority locations + selective fallback
    func startBackgroundPrefetch() {
        guard prefetchTask == nil else {
            print("⚠️ Prefetch already running")
            return
        }
        
        print("🚀 Starting comprehensive background weather prefetch...")
        isPrefetching = true
        
        prefetchTask = Task {
            await performComprehensivePrefetch()
        }
    }
    
    /// Starts fallback prefetch when priority searches fail
    func startFallbackPrefetch(for vibe: WeatherVibe) async {
        print("🌍 Starting fallback prefetch for \(vibe.displayName)...")
        
        fallbackPrefetchTask = Task {
            await performFallbackPrefetch(for: vibe)
        }
        
        await fallbackPrefetchTask?.value
    }
    
    /// Stops all prefetch operations
    func stopBackgroundPrefetch() {
        print("🛑 Stopping all prefetch operations...")
        prefetchTask?.cancel()
        fallbackPrefetchTask?.cancel()
        prefetchTask = nil
        fallbackPrefetchTask = nil
        isPrefetching = false
    }
    
    /// Gets cached weather for a location if available
    func getCachedWeather(for location: GlobalWeatherLocation) -> CurrentWeather? {
        let key = cacheKey(for: location)
        
        guard let cached = weatherCache[key] else {
            return nil
        }
        
        // Check if expired
        if Date().timeIntervalSince(cached.timestamp) > cacheExpirySeconds {
            weatherCache.removeValue(forKey: key)
            return nil
        }
        
        print("💾 Cache HIT for \(location.name)")
        return cached.weather
    }
    
    /// Gets cached weather for current location
    func getCachedCurrentLocationWeather() -> CurrentWeather? {
        let key = "current_location"
        
        guard let cached = weatherCache[key] else {
            return nil
        }
        
        // Check if expired
        if Date().timeIntervalSince(cached.timestamp) > cacheExpirySeconds {
            weatherCache.removeValue(forKey: key)
            return nil
        }
        
        print("💾 Cache HIT for current location")
        return cached.weather
    }
    
    /// Manually cache weather data
    func cacheWeather(_ weather: CurrentWeather, for location: GlobalWeatherLocation) {
        let key = cacheKey(for: location)
        weatherCache[key] = CachedWeather(weather: weather, timestamp: Date())
        print("💾 Cached weather for \(location.name)")
    }
    
    /// Manually cache current location weather
    func cacheCurrentLocationWeather(_ weather: CurrentWeather) {
        let key = "current_location"
        weatherCache[key] = CachedWeather(weather: weather, timestamp: Date())
        print("💾 Cached current location weather")
    }
    
    /// Clears expired cache entries
    func cleanupCache() {
        let beforeCount = weatherCache.count
        let currentTime = Date()
        
        weatherCache = weatherCache.filter { _, cached in
            currentTime.timeIntervalSince(cached.timestamp) <= cacheExpirySeconds
        }
        
        let afterCount = weatherCache.count
        if beforeCount != afterCount {
            print("🧹 Cleaned up \(beforeCount - afterCount) expired cache entries")
        }
    }
    
    // MARK: - Private Methods
    
    /// Performs comprehensive background prefetch (priority + selective fallback)
    private func performComprehensivePrefetch() async {
        print("📡 Starting comprehensive background prefetch...")
        
        // Prefetch current location if available
        if WeatherService.shared.currentLocation != nil {
            await prefetchCurrentLocation()
        }
        
        // Phase 1: Prefetch priority locations
        await prefetchPriorityLocations()
        
        // Phase 2: Selectively prefetch some fallback locations (top priority ones)
        await prefetchSelectiveFallbackLocations()
        
        isPrefetching = false
        print("✅ Comprehensive background prefetch completed")
    }
    
    /// Prefetches priority locations (primary + secondary tiers)
    private func prefetchPriorityLocations() async {
        print("📡 Phase 1: Prefetching priority locations...")
        
        var locationsToCache: [GlobalWeatherLocation] = []
        var seenLocationKeys: Set<String> = []
        
        for vibe in WeatherVibe.allCases {
            // Get top 3 primary locations
            let primaryLocations = database.getLocations(for: vibe, tier: .primary)
            for location in primaryLocations.prefix(3) {
                let key = cacheKey(for: location)
                if !seenLocationKeys.contains(key) {
                    seenLocationKeys.insert(key)
                    locationsToCache.append(location)
                }
            }
            
            // Get top 2 secondary locations for fallback
            let secondaryLocations = database.getLocations(for: vibe, tier: .secondary)
            for location in secondaryLocations.prefix(2) {
                let key = cacheKey(for: location)
                if !seenLocationKeys.contains(key) {
                    seenLocationKeys.insert(key)
                    locationsToCache.append(location)
                }
            }
        }
        
        print("📡 Prefetching \(locationsToCache.count) priority locations...")
        await prefetchLocationBatch(locationsToCache)
    }
    
    /// Selectively prefetches top fallback locations
    private func prefetchSelectiveFallbackLocations() async {
        print("📡 Phase 2: Prefetching selective fallback locations...")
        
        var fallbackLocationsToCache: [GlobalWeatherLocation] = []
        var seenLocationKeys: Set<String> = []
        
        for vibe in WeatherVibe.allCases {
            // Get top 2 fallback locations per vibe
            let fallbackLocations = fallbackDatabase.fallbackLocations[vibe] ?? []
            for location in fallbackLocations.prefix(2) {
                let key = cacheKey(for: location)
                if !seenLocationKeys.contains(key) {
                    seenLocationKeys.insert(key)
                    fallbackLocationsToCache.append(location)
                }
            }
        }
        
        print("📡 Prefetching \(fallbackLocationsToCache.count) selective fallback locations...")
        await prefetchLocationBatch(fallbackLocationsToCache)
    }
    
    /// Performs targeted fallback prefetch for a specific vibe
    private func performFallbackPrefetch(for vibe: WeatherVibe) async {
        print("🌍 Performing targeted fallback prefetch for \(vibe.displayName)...")
        
        let fallbackLocations = fallbackDatabase.fallbackLocations[vibe] ?? []
        let sortedLocations = fallbackLocations.sorted { $0.priority > $1.priority }
        
        // Prefetch top 5 fallback locations for this specific vibe
        let locationsToCache = Array(sortedLocations.prefix(5))
        print("📡 Prefetching \(locationsToCache.count) targeted fallback locations for \(vibe.displayName)...")
        
        await prefetchLocationBatch(locationsToCache, delay: 1.0) // Faster prefetch for targeted search
    }
    
    /// Prefetches a batch of locations with delays
    private func prefetchLocationBatch(_ locations: [GlobalWeatherLocation], delay: Double = 1.5) async {
        for (index, location) in locations.enumerated() {
            // Check if task was cancelled
            if Task.isCancelled {
                print("🛑 Prefetch cancelled")
                break
            }
            
            await prefetchLocation(location)
            
            // Add delay between requests to respect rate limits
            if index < locations.count - 1 {
                try? await Task.sleep(for: .seconds(delay))
            }
        }
    }
    
    /// Prefetches weather for a single location
    private func prefetchLocation(_ location: GlobalWeatherLocation) async {
        let key = cacheKey(for: location)
        
        // Skip if already cached and not expired
        if let existing = weatherCache[key],
           Date().timeIntervalSince(existing.timestamp) < cacheExpirySeconds {
            return
        }
        
        do {
            print("   🔍 Prefetching \(location.name)...")
            let (weather, _) = try await WeatherService.shared.fetchWeather(for: location.location)
            
            weatherCache[key] = CachedWeather(weather: weather, timestamp: Date())
            print("   ✅ Prefetched \(location.name): \(weather.condition.description)")
            
        } catch {
            print("   ❌ Failed to prefetch \(location.name): \(error.localizedDescription)")
        }
    }
    
    /// Prefetches current location weather
    private func prefetchCurrentLocation() async {
        guard let currentLocation = WeatherService.shared.currentLocation else {
            return
        }
        
        let key = "current_location"
        
        // Skip if already cached and not expired
        if let existing = weatherCache[key],
           Date().timeIntervalSince(existing.timestamp) < cacheExpirySeconds {
            return
        }
        
        do {
            print("   🔍 Prefetching current location...")
            let (weather, _) = try await WeatherService.shared.fetchWeather(for: currentLocation)
            
            weatherCache[key] = CachedWeather(weather: weather, timestamp: Date())
            print("   ✅ Prefetched current location: \(weather.condition.description)")
            
        } catch {
            print("   ❌ Failed to prefetch current location: \(error.localizedDescription)")
        }
    }
    
    /// Generates cache key for location
    private func cacheKey(for location: GlobalWeatherLocation) -> String {
        return "\(location.coordinate.latitude),\(location.coordinate.longitude)"
    }
}

// MARK: - Supporting Types

/// Cached weather data with timestamp
private struct CachedWeather {
    let weather: CurrentWeather
    let timestamp: Date
}