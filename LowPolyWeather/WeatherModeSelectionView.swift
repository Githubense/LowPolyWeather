//
//  WeatherModeSelectionView.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import SwiftUI

struct WeatherModeSelectionView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @State private var selectedVibe: WeatherVibe?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                headerSection
                
                currentLocationSection
                
                Divider()
                
                vibeSelectionSection
                
                weatherDataDisplay
                
                // Add bottom padding for better scrolling
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 50)
            }
            .padding(40)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: 600)
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Text("Weather Vibes")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Choose your relaxation experience")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Current Location Section
    
    private var currentLocationSection: some View {
        VStack(spacing: 15) {
            Text("Your Location")
                .font(.title2)
                .fontWeight(.semibold)
            
            Button(action: {
                print("🏠 Current location button pressed")
                Task {
                    print("🔄 Starting current location weather task...")
                    await appModel.showCurrentLocationWeather()
                    print("📱 Opening immersive space...")
                    
                    await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    print("✅ Immersive space opened successfully")
                }
            }) {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundStyle(.blue)
                    
                    Text("Experience Current Weather")
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .disabled(appModel.weatherSpaceHandler.isLoadingCurrentWeather)
        }
    }
    
    // MARK: - Vibe Selection Section
    
    private var vibeSelectionSection: some View {
        VStack(spacing: 20) {
            Text("Find Your Vibe")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Choose manually or let AI suggest based on your mood")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            // Add AI Assistant section
            MoodInputView()
                .padding()
                .background(.gray.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text("Or choose manually:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
                ForEach(WeatherVibe.allCases) { vibe in
                    VibeSelectionCard(
                        vibe: vibe,
                        isSelected: selectedVibe == vibe,
                        isSearching: appModel.weatherSpaceHandler.isSearchingForVibe && selectedVibe == vibe
                    ) {
                        print("🎭 \(vibe.displayName) vibe button pressed")
                        selectedVibe = vibe
                        Task {
                            print("🔄 Starting \(vibe.displayName) weather task...")
                            await appModel.showVibeWeather(vibe)
                            print("📱 Opening immersive space...")
                            
                            await openImmersiveSpace(id: appModel.immersiveSpaceID)
                            print("✅ Immersive space opened successfully for \(vibe.displayName)")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Weather Data Display
    
    private var weatherDataDisplay: some View {
        Group {
            if appModel.weatherSpaceHandler.weatherData.lastUpdated != nil {
                VStack(spacing: 10) {
                    Text("Current Session")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appModel.weatherSpaceHandler.weatherData.locationName)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text(appModel.weatherSpaceHandler.weatherSummary)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Text(appModel.weatherSpaceHandler.formattedLocalTime)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text(appModel.weatherSpaceHandler.formattedLocalDate)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}

// MARK: - Vibe Selection Card

struct VibeSelectionCard: View {
    let vibe: WeatherVibe
    let isSelected: Bool
    let isSearching: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Text(vibe.emoji)
                    .font(.system(size: 30))
                
                Text(vibe.displayName)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(vibe.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                if isSearching {
                    ProgressView()
                        .scaleEffect(0.8)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .padding()
            .background(isSelected ? .blue.opacity(0.2) : .gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? .blue : .clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .disabled(isSearching)
    }
}

#Preview {
    WeatherModeSelectionView()
        .environment(AppModel())
}
