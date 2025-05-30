//
//  VibeSuggestionService.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 30/05/25.
//

import Foundation
import LLM

/// Service that uses local LLM to suggest weather vibes based on user mood
@MainActor
class VibeSuggestionService: ObservableObject {
    static let shared = VibeSuggestionService()
    
    @Published var isLoading = false
    @Published var isModelReady = false
    @Published var loadingProgress: Double = 0.0
    @Published var errorMessage: String?
    @Published var downloadStatus: String = "Ready to download"
    @Published var isDownloading = false
    
    private var llm: LLM?
    private let modelFileName = "qwen3-0.6b-instruct-q4_k_m.gguf"
    
    private init() {
        checkModelAvailability()
    }
    
    /// Check if model is already downloaded or bundled
    private func checkModelAvailability() {
        // First check if model is bundled in app
        if let bundledModelURL = Bundle.main.url(forResource: "qwen3-0.6b-instruct-q4_k_m", withExtension: "gguf") {
            print("📦 Found bundled model at: \(bundledModelURL)")
            Task {
                await loadBundledModel(from: bundledModelURL)
            }
            return
        }
        
        // Check if model was previously downloaded
        if let downloadedModelURL = getDownloadedModelURL(), FileManager.default.fileExists(atPath: downloadedModelURL.path) {
            print("💾 Found downloaded model at: \(downloadedModelURL)")
            Task {
                await loadDownloadedModel(from: downloadedModelURL)
            }
            return
        }
        
        // Model needs to be downloaded
        print("📥 Model needs to be downloaded")
        downloadStatus = "Model not found - ready to download"
    }
    
    /// Get URL for downloaded model in Documents directory
    private func getDownloadedModelURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent(modelFileName)
    }
    
    /// Load bundled model
    private func loadBundledModel(from url: URL) async {
        print("🤖 Loading bundled LLM model...")
        await initializeModelFromURL(url)
    }
    
    /// Load downloaded model
    private func loadDownloadedModel(from url: URL) async {
        print("🤖 Loading downloaded LLM model...")
        await initializeModelFromURL(url)
    }
    
    /// Download model from HuggingFace (following LLM.swift example pattern)
    func downloadModel() async {
        print("📥 Starting model download...")
        isDownloading = true
        isLoading = true
        errorMessage = nil
        downloadStatus = "Preparing download..."
        
        do {
            // Create the model configuration following the example pattern
            let systemPrompt = createSystemPrompt()
            let model = HuggingFaceModel(
                "unsloth/Qwen3-0.6B-GGUF", 
                .Q4_K_M, 
                template: .chatML(systemPrompt)
            )
            
            downloadStatus = "Downloading model..."
            
            // Initialize LLM with download progress (synchronous callback)
            self.llm = try await LLM(from: model) { [weak self] progress in
                // Use Task to update UI on main actor synchronously
                Task { @MainActor in
                    self?.loadingProgress = progress
                    self?.downloadStatus = "Downloading: \(Int(progress * 100))%"
                }
            }
            
            isModelReady = true
            downloadStatus = "Model ready!"
            print("✅ Model downloaded and loaded successfully")
            
        } catch {
            errorMessage = "Failed to download model: \(error.localizedDescription)"
            downloadStatus = "Download failed"
            print("❌ Failed to download model: \(error)")
        }
        
        isDownloading = false
        isLoading = false
    }
    
    /// Initialize model from local URL
    private func initializeModelFromURL(_ url: URL) async {
        print("🤖 Initializing LLM from local file...")
        isLoading = true
        errorMessage = nil
        downloadStatus = "Loading local model..."
        
        do {
            let systemPrompt = createSystemPrompt()
            // Following the bundled model example pattern
            self.llm = LLM(from: url, template: .chatML(systemPrompt))
            
            isModelReady = true
            downloadStatus = "Model ready!"
            print("✅ Local LLM model loaded successfully")
            
        } catch {
            errorMessage = "Failed to load local model: \(error.localizedDescription)"
            downloadStatus = "Failed to load model"
            print("❌ Failed to initialize local LLM: \(error)")
        }
        
        isLoading = false
    }
    
    /// Create system prompt for vibe suggestion
    private func createSystemPrompt() -> String {
        let availableVibes = WeatherVibe.allCases.map { vibe in
            "\(vibe.displayName): \(vibe.description)"
        }.joined(separator: "\n")
        
        return """
        You are a weather vibe assistant for a relaxation app. Your job is to suggest the best weather vibe based on the user's mood or feelings.
        
        Available weather vibes:
        \(availableVibes)
        
        Rules:
        1. Respond with ONLY the vibe name (e.g., "Rainy", "Sunny", "Stormy")
        2. Choose the vibe that best matches the user's emotional state
        3. If uncertain, default to "Sunny" for positive moods or "Rainy" for contemplative moods
        4. Do not explain your choice, just return the vibe name
        
        Examples:
        User: "I'm feeling nostalgic" → Response: "Rainy"
        User: "I'm happy and energetic" → Response: "Sunny" 
        User: "I want to feel cozy" → Response: "Snowy"
        User: "I'm stressed and need calm" → Response: "Misty"
        """
    }
    
    /// Suggest a weather vibe based on user input (following the example pattern)
    func suggestVibe(for moodDescription: String) async -> WeatherVibe? {
        guard let llm = llm, isModelReady else {
            print("⚠️ LLM not ready for suggestions")
            return nil
        }
        
        print("🤖 Getting vibe suggestion for: '\(moodDescription)'")
        isLoading = true
        errorMessage = nil
        
        // Following the example pattern: preprocess -> getCompletion
        let processedInput = llm.preprocess(moodDescription, llm.history)
        
        do {
            let response = await llm.getCompletion(from: processedInput)
            let suggestion = response.trimmingCharacters(in: .whitespacesAndNewlines)
            
            print("🤖 LLM suggested: '\(suggestion)'")
            
            // Parse the suggestion to a valid WeatherVibe
            let suggestedVibe = parseVibeFromResponse(suggestion)
            
            if let vibe = suggestedVibe {
                print("✅ Mapped to vibe: \(vibe.displayName)")
            } else {
                print("⚠️ Could not map '\(suggestion)' to a valid vibe, defaulting to Sunny")
            }
            
            isLoading = false
            return suggestedVibe ?? .sunny // Default fallback
            
        } catch {
            errorMessage = "Failed to get vibe suggestion: \(error.localizedDescription)"
            print("❌ Error getting vibe suggestion: \(error)")
            isLoading = false
            return nil
        }
    }
    
    /// Parse LLM response to WeatherVibe
    private func parseVibeFromResponse(_ response: String) -> WeatherVibe? {
        let lowercaseResponse = response.lowercased()
        
        for vibe in WeatherVibe.allCases {
            if lowercaseResponse.contains(vibe.displayName.lowercased()) {
                return vibe
            }
        }
        
        // Fallback matching for common variations
        if lowercaseResponse.contains("rain") || lowercaseResponse.contains("wet") {
            return .rainy
        } else if lowercaseResponse.contains("storm") || lowercaseResponse.contains("thunder") {
            return .stormy
        } else if lowercaseResponse.contains("snow") || lowercaseResponse.contains("cold") || lowercaseResponse.contains("winter") {
            return .snowy
        } else if lowercaseResponse.contains("wind") || lowercaseResponse.contains("breez") {
            return .breezy
        } else if lowercaseResponse.contains("sun") || lowercaseResponse.contains("bright") || lowercaseResponse.contains("clear") {
            return .sunny
        } else if lowercaseResponse.contains("mist") || lowercaseResponse.contains("calm") {
            return .misty
        } else if lowercaseResponse.contains("fog") {
            return .foggy
        } else if lowercaseResponse.contains("cloud") || lowercaseResponse.contains("gray") {
            return .cloudy
        }
        
        return nil
    }
    
    /// Delete downloaded model to free up space
    func deleteDownloadedModel() {
        guard let modelURL = getDownloadedModelURL() else { return }
        
        do {
            try FileManager.default.removeItem(at: modelURL)
            print("🗑️ Downloaded model deleted successfully")
            isModelReady = false
            llm = nil
            downloadStatus = "Model deleted - ready to download"
        } catch {
            print("❌ Failed to delete model: \(error)")
            errorMessage = "Failed to delete model: \(error.localizedDescription)"
        }
    }
    
    /// Get model file size information
    func getModelInfo() -> (downloaded: Bool, size: String?) {
        guard let modelURL = getDownloadedModelURL() else {
            return (false, nil)
        }
        
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: modelURL.path)
            if let fileSize = attributes[.size] as? Int64 {
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = [.useMB, .useGB]
                formatter.countStyle = .file
                return (true, formatter.string(fromByteCount: fileSize))
            }
        } catch {
            print("❌ Failed to get model file size: \(error)")
        }
        
        return (false, nil)
    }
    
    /// Retry model initialization
    func retryInitialization() async {
        checkModelAvailability()
    }
}