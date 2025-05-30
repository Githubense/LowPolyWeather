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
    private let modelCacheKey = "AIModelCached"
    
    private init() {
        // Start background model initialization
        Task {
            await initializeModelInBackground()
        }
    }
    
    /// Initialize model in background - automatically download if needed
    private func initializeModelInBackground() async {
        print("🚀 Starting background model initialization...")
        
        // First check if model is bundled in app
        if let bundledModelURL = Bundle.main.url(forResource: "qwen3-0.6b-instruct-q4_k_m", withExtension: "gguf") {
            print("📦 Found bundled model at: \(bundledModelURL)")
            await loadBundledModel(from: bundledModelURL)
            return
        }
        
        // Check if model was previously downloaded and cached
        if let cachedModelURL = getCachedModelURL(), 
           FileManager.default.fileExists(atPath: cachedModelURL.path),
           UserDefaults.standard.bool(forKey: modelCacheKey) {
            print("💾 Found cached model at: \(cachedModelURL)")
            await loadCachedModel(from: cachedModelURL)
            return
        }
        
        // Model needs to be downloaded - start automatic background download
        print("📥 Starting automatic model download in background...")
        downloadStatus = "Downloading AI model automatically..."
        await downloadModelAutomatically()
    }
    
    /// Get URL for cached model in app's caches directory
    private func getCachedModelURL() -> URL? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("❌ Could not access caches directory")
            return nil
        }
        
        let modelCacheDirectory = cachesDirectory.appendingPathComponent("AIModels")
        
        // Create directory if it doesn't exist
        if !FileManager.default.fileExists(atPath: modelCacheDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: modelCacheDirectory, withIntermediateDirectories: true)
                print("📁 Created model cache directory at: \(modelCacheDirectory)")
            } catch {
                print("❌ Failed to create model cache directory: \(error)")
                return nil
            }
        }
        
        return modelCacheDirectory.appendingPathComponent(modelFileName)
    }
    
    /// Get URL for downloaded model in Documents directory (fallback)
    private func getDownloadedModelURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent(modelFileName)
    }
    
    /// Load bundled model
    private func loadBundledModel(from url: URL) async {
        print("🤖 Loading bundled LLM model...")
        downloadStatus = "Loading bundled model..."
        await initializeModelFromURL(url)
    }
    
    /// Load cached model
    private func loadCachedModel(from url: URL) async {
        print("🤖 Loading cached LLM model...")
        downloadStatus = "Loading cached model..."
        await initializeModelFromURL(url)
    }
    
    /// Download model automatically in background
    private func downloadModelAutomatically() async {
        print("📥 Starting automatic model download...")
        isDownloading = true
        isLoading = true
        errorMessage = nil
        
        do {
            let systemPrompt = createSystemPrompt()
            let model = HuggingFaceModel(
                "unsloth/Qwen3-0.6B-GGUF", 
                .Q4_K_M, 
                template: .chatML(systemPrompt)
            )
            
            downloadStatus = "Downloading model in background..."
            
            // Initialize LLM with download progress
            let llmInstance = try await LLM(from: model) { [weak self] progress in
                Task { @MainActor in
                    self?.loadingProgress = progress
                    self?.downloadStatus = "Downloading: \(Int(progress * 100))%"
                }
            }
            
            self.llm = llmInstance
            
            // Save model to cache for future use
            await saveModelToCache()
            
            isModelReady = true
            downloadStatus = "Model ready!"
            print("✅ Model downloaded and cached successfully")
            
        } catch {
            errorMessage = "Failed to download model: \(error.localizedDescription)"
            downloadStatus = "Download failed - will retry later"
            print("❌ Failed to download model: \(error)")
            
            // Schedule retry in 30 seconds
            Task {
                try? await Task.sleep(nanoseconds: 30_000_000_000) // 30 seconds
                await retryDownloadInBackground()
            }
        }
        
        isDownloading = false
        isLoading = false
    }
    
    /// Manual download model
    func downloadModel() async {
        print("📥 Starting manual model download...")
        isDownloading = true
        isLoading = true
        errorMessage = nil
        downloadStatus = "Preparing download..."
        
        do {
            let systemPrompt = createSystemPrompt()
            let model = HuggingFaceModel(
                "unsloth/Qwen3-0.6B-GGUF", 
                .Q4_K_M, 
                template: .chatML(systemPrompt)
            )
            
            downloadStatus = "Downloading model..."
            
            // Initialize LLM with download progress
            let llmInstance = try await LLM(from: model) { [weak self] progress in
                Task { @MainActor in
                    self?.loadingProgress = progress
                    self?.downloadStatus = "Downloading: \(Int(progress * 100))%"
                }
            }
            
            self.llm = llmInstance
            
            // Save model to cache
            await saveModelToCache()
            
            isModelReady = true
            downloadStatus = "Model ready!"
            print("✅ Model downloaded and cached successfully")
            
        } catch {
            errorMessage = "Failed to download model: \(error.localizedDescription)"
            downloadStatus = "Download failed"
            print("❌ Failed to download model: \(error)")
        }
        
        isDownloading = false
        isLoading = false
    }
    
    /// Save model to persistent cache
    private func saveModelToCache() async {
        // Mark model as cached in UserDefaults
        UserDefaults.standard.set(true, forKey: modelCacheKey)
        UserDefaults.standard.synchronize()
        
        // Note: LLM.swift automatically handles model file caching
        // The model files are stored in the system cache by the library
        print("💾 Model marked as cached for future use")
    }
    
    /// Retry download in background
    private func retryDownloadInBackground() async {
        guard !isModelReady && !isDownloading else { return }
        
        print("🔄 Retrying model download in background...")
        downloadStatus = "Retrying download..."
        await downloadModelAutomatically()
    }
    
    /// Initialize model from local URL
    private func initializeModelFromURL(_ url: URL) async {
        print("🤖 Initializing LLM from local file...")
        isLoading = true
        errorMessage = nil
        
        let systemPrompt = createSystemPrompt()
        let llmInstance = LLM(from: url, template: .chatML(systemPrompt))
        
        if llmInstance != nil {
            self.llm = llmInstance
            isModelReady = true
            downloadStatus = "Model ready!"
            print("✅ Local LLM model loaded successfully")
        } else {
            errorMessage = "Failed to load local model from URL"
            downloadStatus = "Failed to load model"
            print("❌ Failed to initialize local LLM from URL")
        }
        
        isLoading = false
    }

    /// Create a simplified, focused system prompt for single-request classification
    private func createSystemPrompt() -> String {
        return """
        You are a weather vibe classifier. Respond with ONE WORD only from these options:
        Rainy, Stormy, Snowy, Breezy, Sunny, Misty, Foggy, Cloudy
        
        Classification rules:
        - nostalgic/melancholy/sad/contemplative → Rainy
        - angry/intense/passionate/powerful → Stormy  
        - cozy/winter/hibernate/comfort → Snowy
        - free/light/movement/beach/ocean → Breezy
        - energetic/motivated/happy/optimistic → Sunny
        - calm/meditation/peace/gentle → Misty
        - confused/clarity/mysterious → Foggy
        - neutral/mild/overcast → Cloudy
        
        Respond with ONLY the vibe name. No explanations.
        """
    }

    /// Suggest a weather vibe with completely fresh LLM instance (no context carryover)
    func suggestVibe(for moodDescription: String) async -> WeatherVibe? {
        print("🤖 Getting vibe suggestion for: '\(moodDescription)'")
        isLoading = true
        errorMessage = nil
        
        // Create a completely fresh LLM instance for this single request
        let freshLLM = await createFreshLLMInstance()
        
        guard let freshLLM = freshLLM else {
            print("⚠️ Could not create fresh LLM instance, using fallback")
            isLoading = false
            return getFallbackVibeFromUserInput(moodDescription)
        }
        
        // Create a simple, direct prompt without chat formatting
        let simplePrompt = """
        \(moodDescription)
        
        Choose ONE word: Rainy, Stormy, Snowy, Breezy, Sunny, Misty, Foggy, Cloudy
        
        Answer:
        """
        
        // Get response from fresh instance
        let response = await freshLLM.getCompletion(from: simplePrompt)
        let cleanedSuggestion = cleanResponse(response)
        
        print("🤖 Fresh LLM suggested: '\(cleanedSuggestion)'")
        
        // Parse the suggestion to a valid WeatherVibe
        let suggestedVibe = parseVibeFromResponse(cleanedSuggestion)
        
        if let vibe = suggestedVibe {
            print("✅ Mapped to vibe: \(vibe.displayName)")
        } else {
            print("⚠️ Could not map '\(cleanedSuggestion)' to a valid vibe, using fallback")
            isLoading = false
            return getFallbackVibeFromUserInput(moodDescription)
        }
        
        isLoading = false
        return suggestedVibe ?? getFallbackVibeFromUserInput(moodDescription)
    }
    
    /// Create a completely fresh LLM instance for isolated requests
    private func createFreshLLMInstance() async -> LLM? {
        // First check if we have a bundled model
        if let bundledModelURL = Bundle.main.url(forResource: "qwen3-0.6b-instruct-q4_k_m", withExtension: "gguf") {
            print("🔄 Creating fresh LLM from bundled model")
            return createFreshLLMFromURL(bundledModelURL)
        }
        
        // Check for cached model
        if let cachedModelURL = getCachedModelURL(), 
           FileManager.default.fileExists(atPath: cachedModelURL.path) {
            print("🔄 Creating fresh LLM from cached model")
            return createFreshLLMFromURL(cachedModelURL)
        }
        
        // Check for downloaded model in Documents
        if let downloadedModelURL = getDownloadedModelURL(),
           FileManager.default.fileExists(atPath: downloadedModelURL.path) {
            print("🔄 Creating fresh LLM from downloaded model")
            return createFreshLLMFromURL(downloadedModelURL)
        }
        
        // If no local model available, use the main instance (fallback)
        if let mainLLM = llm, isModelReady {
            print("🔄 Using main LLM instance as fallback")
            // Clear its history completely
            mainLLM.history.removeAll()
            return mainLLM
        }
        
        print("❌ No LLM instance available")
        return nil
    }
    
    /// Create a fresh LLM instance from a local file URL with minimal context
    private func createFreshLLMFromURL(_ url: URL) -> LLM? {
        // Create a very simple system prompt for classification only
        let minimalSystemPrompt = """
        Classify mood into weather: Rainy, Stormy, Snowy, Breezy, Sunny, Misty, Foggy, Cloudy
        """
        
        // Create completely fresh instance with minimal template
        let freshLLM = LLM(from: url, template: .chatML(minimalSystemPrompt))
        
        return freshLLM
    }
    
    /// Alternative suggestion method using simple keyword-based completion
    func suggestVibeSimple(for moodDescription: String) async -> WeatherVibe? {
        print("🤖 Getting simple vibe suggestion for: '\(moodDescription)'")
        isLoading = true
        errorMessage = nil
        
        // Try to get a fresh LLM instance
        if let freshLLM = await createFreshLLMInstance() {
            // Use the absolute simplest prompt possible
            let ultraSimplePrompt = "\(moodDescription) = "
            
            let response = await freshLLM.getCompletion(from: ultraSimplePrompt)
            let cleanedSuggestion = cleanResponse(response)
            
            print("🤖 Simple LLM suggested: '\(cleanedSuggestion)'")
            
            if let vibe = parseVibeFromResponse(cleanedSuggestion) {
                print("✅ Mapped to vibe: \(vibe.displayName)")
                isLoading = false
                return vibe
            }
        }
        
        // Fall back to keyword-based logic
        print("🔄 Using keyword-based fallback")
        isLoading = false
        return getFallbackVibeFromUserInput(moodDescription)
    }
    
    /// Enhanced fallback with better keyword mapping for "hot" scenarios
    private func getFallbackVibeFromUserInput(_ input: String) -> WeatherVibe {
        let lowercaseInput = input.lowercased()
        
        print("🔄 Using fallback logic for: '\(input)'")
        
        // Enhanced keyword matching including "hot" scenarios
        if lowercaseInput.contains("nostalgic") || lowercaseInput.contains("melancholy") || 
           lowercaseInput.contains("sad") || lowercaseInput.contains("contemplat") ||
           lowercaseInput.contains("grief") || lowercaseInput.contains("rain") {
            return .rainy
        } else if lowercaseInput.contains("angry") || lowercaseInput.contains("intense") || 
                  lowercaseInput.contains("passionate") || lowercaseInput.contains("powerful") || 
                  lowercaseInput.contains("dramatic") || lowercaseInput.contains("storm") {
            return .stormy
        } else if lowercaseInput.contains("cozy") || lowercaseInput.contains("winter") || 
                  lowercaseInput.contains("hibernate") || lowercaseInput.contains("comfort") ||
                  lowercaseInput.contains("snow") {
            return .snowy
        } else if lowercaseInput.contains("free") || lowercaseInput.contains("light") || 
                  lowercaseInput.contains("beach") || lowercaseInput.contains("ocean") ||
                  lowercaseInput.contains("breez") || lowercaseInput.contains("wind") ||
                  lowercaseInput.contains("movement") || lowercaseInput.contains("fresh") {
            return .breezy
        } else if lowercaseInput.contains("energetic") || lowercaseInput.contains("motivated") || 
                  lowercaseInput.contains("happy") || lowercaseInput.contains("optimistic") || 
                  lowercaseInput.contains("joyful") || lowercaseInput.contains("sun") ||
                  lowercaseInput.contains("hot") || lowercaseInput.contains("warm") ||
                  lowercaseInput.contains("heat") || lowercaseInput.contains("anime") {
            return .sunny
        } else if lowercaseInput.contains("meditat") || lowercaseInput.contains("calm") || 
                  lowercaseInput.contains("peace") || lowercaseInput.contains("gentle") ||
                  lowercaseInput.contains("relax") || lowercaseInput.contains("mist") {
            return .misty
        } else if lowercaseInput.contains("confused") || lowercaseInput.contains("clarity") || 
                  lowercaseInput.contains("mysterious") || lowercaseInput.contains("fog") {
            return .foggy
        } else {
            return .cloudy
        }
    }
    
    /// Reinitialize the main LLM instance (useful when it gets corrupted)
    func reinitializeLLM() async {
        print("🔄 Reinitializing main LLM instance...")
        isModelReady = false
        llm = nil
        await initializeModelInBackground()
    }
    
    /// Create a simplified system prompt that uses minimal context
    private func createMinimalSystemPrompt() -> String {
        return "Classify mood as: Rainy, Stormy, Snowy, Breezy, Sunny, Misty, Foggy, Cloudy"
    }

    /// Clean AI response to extract just the vibe name
    private func cleanResponse(_ response: String) -> String {
        let cleaned = response
            .replacingOccurrences(of: "<think>", with: "")
            .replacingOccurrences(of: "</think>", with: "")
            .replacingOccurrences(of: "<|im_start|>", with: "")
            .replacingOccurrences(of: "<|im_end|>", with: "")
            .replacingOccurrences(of: "assistant", with: "")
            .replacingOccurrences(of: "user", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Extract the last meaningful word (which should be the vibe)
        let lines = cleaned.components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        let lastLine = lines.last ?? cleaned
        
        // Get the first word of the last line (the vibe name)
        let words = lastLine.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map { $0.trimmingCharacters(in: .punctuationCharacters) }
        
        return words.first ?? lastLine
    }

    /// Parse LLM response to WeatherVibe with improved accuracy
    private func parseVibeFromResponse(_ response: String) -> WeatherVibe? {
        let cleanedResponse = response.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("🔍 Parsing cleaned response: '\(cleanedResponse)'")
        
        // Direct exact matches first
        for vibe in WeatherVibe.allCases {
            if cleanedResponse == vibe.displayName.lowercased() {
                return vibe
            }
        }
        
        // Then partial matches
        for vibe in WeatherVibe.allCases {
            if cleanedResponse.contains(vibe.displayName.lowercased()) {
                return vibe
            }
        }
        
        return nil
    }
    
    /// Delete cached model to free up space
    func deleteDownloadedModel() {
        // Clear cache flag
        UserDefaults.standard.removeObject(forKey: modelCacheKey)
        UserDefaults.standard.synchronize()
        
        // Try to delete from both possible locations
        if let cachedModelURL = getCachedModelURL() {
            try? FileManager.default.removeItem(at: cachedModelURL)
        }
        
        if let downloadedModelURL = getDownloadedModelURL() {
            try? FileManager.default.removeItem(at: downloadedModelURL)
        }
        
        print("🗑️ Model cache cleared")
        isModelReady = false
        llm = nil
        downloadStatus = "Model deleted - will download automatically"
        
        // Restart background download
        Task {
            await initializeModelInBackground()
        }
    }
    
    /// Get model file size information
    func getModelInfo() -> (downloaded: Bool, size: String?) {
        let isCached = UserDefaults.standard.bool(forKey: modelCacheKey)
        
        guard isCached else {
            return (false, nil)
        }
        
        // Check cached model first
        if let cachedModelURL = getCachedModelURL(),
           FileManager.default.fileExists(atPath: cachedModelURL.path) {
            return getFileSizeInfo(for: cachedModelURL)
        }
        
        // Check downloaded model as fallback
        if let downloadedModelURL = getDownloadedModelURL(),
           FileManager.default.fileExists(atPath: downloadedModelURL.path) {
            return getFileSizeInfo(for: downloadedModelURL)
        }
        
        return (false, nil)
    }
    
    /// Get file size info for a specific URL
    private func getFileSizeInfo(for url: URL) -> (downloaded: Bool, size: String?) {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
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
        await initializeModelInBackground()
    }
    
    /// Check if model is available (cached or ready)
    var isModelAvailable: Bool {
        return isModelReady || UserDefaults.standard.bool(forKey: modelCacheKey)
    }
}