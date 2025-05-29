//
//  AppModel.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import SwiftUI

/// Main app model
@MainActor
@Observable
class AppModel {
    
    // MARK: - Immersive Space
    
    let immersiveSpaceID = "ImmersiveSpace"
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    // MARK: - Weather Handler
    
    var weatherSpaceHandler = WeatherSpaceHandler()
    
    // MARK: - Navigation Actions
    
    /// Shows current location weather and prepares for immersive space
    func showCurrentLocationWeather() async {
        print("🏠 Preparing current location weather...")
        await weatherSpaceHandler.loadCurrentLocationWeather()
        print("✅ Current location weather loaded successfully")
    }
    
    /// Shows weather for a specific vibe and prepares for immersive space
    func showVibeWeather(_ vibe: WeatherVibe) async {
        print("🎭 Preparing \(vibe.displayName) weather vibe...")
        await weatherSpaceHandler.findVibeWeather(for: vibe)
        print("✅ \(vibe.displayName) weather loaded successfully")
    }
    
    /// Refreshes the current weather data
    func refreshWeather() async {
        await weatherSpaceHandler.refreshCurrentWeather()
    }
}

enum ImmersiveSpaceState {
    case closed
    case open
    case inTransition  // Added missing case
}
