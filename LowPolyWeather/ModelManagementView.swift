//
//  ModelManagementView.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 30/05/25.
//

import SwiftUI

struct ModelManagementView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vibeSuggestionService = VibeSuggestionService.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                headerSection
                
                modelStatusSection
                
                actionSection
                
                Spacer()
            }
            .padding()
            .navigationTitle("AI Model Management")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 50))
                .foregroundStyle(.blue)
            
            Text("AI Model Management")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Manage your local AI model for vibe suggestions")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Model Status Section
    
    private var modelStatusSection: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Status:")
                    .fontWeight(.medium)
                Spacer()
                statusBadge
            }
            
            HStack {
                Text("Storage:")
                    .fontWeight(.medium)
                Spacer()
                Text(storageInfo)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text("Model:")
                    .fontWeight(.medium)
                Spacer()
                Text("Qwen3-0.6B (Q4_K_M)")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // MARK: - Action Section
    
    private var actionSection: some View {
        VStack(spacing: 15) {
            if !vibeSuggestionService.isModelReady {
                downloadButton
            } else {
                redownloadButton
                deleteButton
            }
        }
    }
    
    // MARK: - Status Badge
    
    private var statusBadge: some View {
        Group {
            if vibeSuggestionService.isModelReady {
                Label("Ready", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            } else if vibeSuggestionService.isDownloading || vibeSuggestionService.isLoading {
                Label("Loading", systemImage: "clock")
                    .foregroundStyle(.orange)
            } else {
                Label("Not Available", systemImage: "xmark.circle")
                    .foregroundStyle(.red)
            }
        }
        .font(.caption)
        .fontWeight(.medium)
    }
    
    // MARK: - Storage Info
    
    private var storageInfo: String {
        let modelInfo = vibeSuggestionService.getModelInfo()
        if modelInfo.downloaded, let size = modelInfo.size {
            return size
        } else {
            return "Not downloaded"
        }
    }
    
    // MARK: - Action Buttons
    
    private var downloadButton: some View {
        Button(action: {
            Task {
                await vibeSuggestionService.downloadModel()
            }
        }) {
            HStack {
                if vibeSuggestionService.isDownloading {
                    ProgressView()
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "arrow.down.circle")
                }
                
                Text(vibeSuggestionService.isDownloading ? "Downloading..." : "Download Model")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(vibeSuggestionService.isDownloading)
        .buttonStyle(.plain)
    }
    
    private var redownloadButton: some View {
        Button(action: {
            Task {
                vibeSuggestionService.deleteDownloadedModel()
                await vibeSuggestionService.downloadModel()
            }
        }) {
            HStack {
                Image(systemName: "arrow.clockwise")
                Text("Re-download Model")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue.opacity(0.1))
            .foregroundStyle(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
    
    private var deleteButton: some View {
        Button(action: {
            vibeSuggestionService.deleteDownloadedModel()
        }) {
            HStack {
                Image(systemName: "trash")
                Text("Delete Model")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.red.opacity(0.1))
            .foregroundStyle(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ModelManagementView()
}