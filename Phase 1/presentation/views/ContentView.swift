//
//  ContentView.swift
//  Phase 1
//
//  Created by specktro on 25/11/25.
//

import SwiftUI

// ASSIGNMENT 1.1: CardView Component

// Requirements:
// ✅ CardView shows: image, title, description
// ✅ CardView is reusable (takes parameters)
// ✅ Use at least 10 different modifiers
// ✅ Build a feed with 5+ cards
// ✅ Demonstrate that modifier order matters

struct CardView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundStyle(Color.cyan)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.default)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CardView(imageName: "tree.fill", title: "Tree", description: "Nature's air purifier")
                CardView(imageName: "cloud.sleet.fill", title: "Sleet", description: "Winter precipitation")
                CardView(imageName: "sun.dust.fill", title: "Dusty Sun", description: "Hazy weather conditions")
                CardView(imageName: "moon.dust.fill", title: "Dusty Moon", description: "Lunar surface features")
                CardView(imageName: "carbon.dioxide.cloud.fill", title: "CO2", description: "Greenhouse gas indicator")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
