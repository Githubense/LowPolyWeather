//
//  QuickMoodSuggestions.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 30/05/25.
//

import SwiftUI

/// Quick mood suggestion buttons for common feelings
struct QuickMoodSuggestions: View {
    let onMoodSelected: (String) -> Void
    
    private let commonMoods = [
        ("😌", "relaxed and peaceful"),     // → Cloudy/Misty
        ("😢", "nostalgic and melancholy"), // → Rainy
        ("😴", "cozy and want to hibernate"), // → Snowy
        ("⚡️", "energetic and motivated"), // → Sunny
        ("🧘‍♀️", "need deep meditation"),  // → Misty
        ("💭", "confused and seeking clarity"), // → Foggy
        ("🌅", "optimistic and hopeful"),   // → Sunny
        ("😤", "frustrated and intense"),   // → Stormy
        ("🕊️", "free and light"),          // → Breezy
        ("☁️", "mildly contemplative"),     // → Cloudy
        ("🔥", "passionate and powerful"),  // → Stormy
        ("❄️", "want winter comfort")       // → Snowy
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Quick moods:")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
                ForEach(commonMoods, id: \.0) { emoji, mood in
                    Button(action: {
                        onMoodSelected("I'm feeling \(mood)")
                    }) {
                        VStack(spacing: 4) {
                            Text(emoji)
                                .font(.title3)
                            Text(mood.components(separatedBy: " ").first ?? "")
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    QuickMoodSuggestions { mood in
        print("Selected mood: \(mood)")
    }
    .padding()
}