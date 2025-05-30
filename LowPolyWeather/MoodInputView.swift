//
//  MoodInputView.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 30/05/25.
//

import SwiftUI

struct MoodInputView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @StateObject private var vibeSuggestionService = VibeSuggestionService.shared
    
    @State private var moodInput = ""
    @State private var suggestedVibe: WeatherVibe?
    @State private var showingSuggestion = false
    @State private var isProcessing = false
    @State private var showingModelManagement = false
    
    var body: some View {
        VStack(spacing: 20) {
            headerSection
            
            if vibeSuggestionService.isModelReady {
                moodInputSection
                
                if showingSuggestion {
                    suggestionSection
                }
            } else {
                modelManagementSection
            }
            
            // Model management button (always visible)
            modelManagementButton
        }
        .padding(30)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .sheet(isPresented: $showingModelManagement) {
            ModelManagementView()
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Text("🤖 AI Vibe Assistant")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Describe how you're feeling and I'll suggest the perfect weather vibe")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Mood Input Section
    
    private var moodInputSection: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text("How are you feeling?")
                    .font(.headline)
                    .fontWeight(.medium)
                
                TextField("e.g., 'I'm feeling nostalgic' or 'I want to feel energized'", text: $moodInput, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3)
                
                // Add quick mood suggestions
                QuickMoodSuggestions { mood in
                    moodInput = mood
                }
            }
            
            Button(action: {
                Task {
                    await getSuggestion()
                }
            }) {
                HStack {
                    if isProcessing {
                        ProgressView()
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "sparkles")
                    }
                    
                    Text(isProcessing ? "Getting Suggestion..." : "Get AI Suggestion")
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue.opacity(0.1))
                .foregroundStyle(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(moodInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isProcessing)
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Model Management Section
    
    private var modelManagementSection: some View {
        VStack(spacing: 15) {
            if vibeSuggestionService.isDownloading {
                VStack(spacing: 10) {
                    ProgressView(value: vibeSuggestionService.loadingProgress) {
                        Text("Downloading AI Model...")
                            .font(.headline)
                    } currentValueLabel: {
                        Text("\(Int(vibeSuggestionService.loadingProgress * 100))%")
                            .font(.caption)
                    }
                    
                    Text(vibeSuggestionService.downloadStatus)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else if vibeSuggestionService.isLoading {
                VStack(spacing: 10) {
                    ProgressView()
                    Text("Loading AI Model...")
                        .font(.headline)
                    
                    Text(vibeSuggestionService.downloadStatus)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else if let errorMessage = vibeSuggestionService.errorMessage {
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title)
                        .foregroundStyle(.orange)
                    
                    Text("AI Model Error")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry") {
                        Task {
                            await vibeSuggestionService.retryInitialization()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                // Model needs to be downloaded
                VStack(spacing: 15) {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                    
                    Text("Download AI Model")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Download a small AI model (~500MB) to get personalized vibe suggestions based on your mood")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        Task {
                            await vibeSuggestionService.downloadModel()
                        }
                    }) {
                        Text("Download Model")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    // MARK: - Model Management Button
    
    private var modelManagementButton: some View {
        Button("Model Settings") {
            showingModelManagement = true
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
    
    // MARK: - Suggestion Section
    
    private var suggestionSection: some View {
        VStack(spacing: 15) {
            if let vibe = suggestedVibe {
                VStack(spacing: 10) {
                    Text("✨ AI Suggestion")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text(vibe.emoji)
                            .font(.system(size: 40))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(vibe.displayName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text(vibe.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    Task {
                        await useSuggestion(vibe)
                    }
                }) {
                    Text("Experience This Vibe")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green.opacity(0.1))
                        .foregroundStyle(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
                
                Button("Try Different Mood") {
                    resetSuggestion()
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
    
    // MARK: - Actions
    
    private func getSuggestion() async {
        guard !moodInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        isProcessing = true
        
        let suggestion = await vibeSuggestionService.suggestVibe(for: moodInput)
        
        suggestedVibe = suggestion
        showingSuggestion = suggestion != nil
        isProcessing = false
        
        if suggestion == nil {
            print("⚠️ Could not get vibe suggestion")
        }
    }
    
    private func useSuggestion(_ vibe: WeatherVibe) async {
        print("🎭 Using AI suggested vibe: \(vibe.displayName)")
        await appModel.showVibeWeather(vibe)
        await openImmersiveSpace(id: appModel.immersiveSpaceID)
    }
    
    private func resetSuggestion() {
        moodInput = ""
        suggestedVibe = nil
        showingSuggestion = false
    }
}

#Preview {
    MoodInputView()
        .environment(AppModel())
}