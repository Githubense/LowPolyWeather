//
//  ContentView.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        NavigationStack {
            VStack {
                if appModel.immersiveSpaceState == .open {
                    // Show controls when immersive space is open
                    ImmersiveControlsView()
                } else {
                    // Show weather mode selection
                    WeatherModeSelectionView()
                }
            }
            .navigationTitle("Low Poly Weather")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(appModel.immersiveSpaceState == .open ? "Exit" : "Enter") {
                        Task {
                            if appModel.immersiveSpaceState == .open {
                                await dismissImmersiveSpace()
                                appModel.immersiveSpaceState = .closed
                            } else {
                                appModel.immersiveSpaceState = .inTransition
                                await openImmersiveSpace(id: appModel.immersiveSpaceID)
                            }
                        }
                    }
                    .disabled(appModel.immersiveSpaceState == .inTransition)
                }
            }
        }
        .task {
            // Request location permission on launch
            WeatherService.shared.requestLocationPermission()
        }
    }
}

// MARK: - Immersive Controls View

struct ImmersiveControlsView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Show weather info only if valid data is available
            if appModel.weatherSpaceHandler.isWeatherDataValid {
                // Weather info display
                VStack(spacing: 10) {
                    Text(appModel.weatherSpaceHandler.weatherData.locationName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(appModel.weatherSpaceHandler.weatherSummary)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text(appModel.weatherSpaceHandler.formattedLocalTime)
                        Text("•")
                        Text(appModel.weatherSpaceHandler.formattedLocalDate)
                    }
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                }
            } else if appModel.weatherSpaceHandler.weatherData.isLoading {
                // Loading state
                VStack(spacing: 10) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Loading weather data...")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
            } else if let errorMessage = appModel.weatherSpaceHandler.weatherData.errorMessage {
                // Error state
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title)
                        .foregroundStyle(.orange)
                    Text("Weather Unavailable")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            } else {
                // No valid data state
                VStack(spacing: 10) {
                    Image(systemName: "location.slash")
                        .font(.title)
                        .foregroundStyle(.gray)
                    Text("No Weather Data")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Please select a weather vibe or enable location services")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            
            // Control buttons
            HStack(spacing: 15) {
                Button("Current Location") {
                    Task {
                        await appModel.weatherSpaceHandler.loadCurrentLocationWeather()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(appModel.weatherSpaceHandler.isLoadingCurrentWeather)
                
                Button("Refresh") {
                    Task {
                        await appModel.weatherSpaceHandler.refreshCurrentWeather()
                    }
                }
                .buttonStyle(.bordered)
                .disabled(appModel.weatherSpaceHandler.weatherData.isLoading)
            }
            
            // Weather vibe selection
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                ForEach(WeatherVibe.allCases, id: \.self) { vibe in
                    Button(vibe.displayName) {
                        Task {
                            await appModel.weatherSpaceHandler.findVibeWeather(for: vibe)
                        }
                    }
                    .buttonStyle(.bordered)
                    .font(.caption)
                    .disabled(appModel.weatherSpaceHandler.isSearchingForVibe)
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
