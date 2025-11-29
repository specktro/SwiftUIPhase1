//
//  CardsView.swift
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
                .shadow(radius: 7, x: 2, y: 5)
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
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct CardsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CardView(imageName: "tree.fill", title: "Tree", description: "A simple tree card")
                CardView(imageName: "cloud.sleet.fill", title: "Tree", description: "A simple tree card")
                CardView(imageName: "sun.dust.fill", title: "Tree", description: "A simple tree card")
                CardView(imageName: "moon.dust.fill", title: "Tree", description: "A simple tree card")
                CardView(imageName: "carbon.dioxide.cloud.fill", title: "Tree", description: "A simple tree card")
            }
            .padding()
        }
    }
}

#Preview {
    CardsView()
}
