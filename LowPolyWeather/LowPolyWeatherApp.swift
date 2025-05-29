//
//  LowPolyWeatherApp.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import SwiftUI
import WeatherKit

@main
struct LowPolyWeatherApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
                .task {
                    // Request location permission on app launch
                    WeatherService.shared.requestLocationPermission()
                    
                    // Initialize smart weather manager (starts background prefetch)
                    _ = SmartWeatherLocationManager.shared
                    
                    print("🚀 LowPolyWeather launched with smart weather management")
                }
        }
        .defaultSize(width: 1280, height: 720)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
