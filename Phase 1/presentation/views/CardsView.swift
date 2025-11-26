//
//  CardsView.swift
//  Phase 1
//
//  Created by specktro on 25/11/25.
//

import SwiftUI

struct CardView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

struct CardsView: View {
    var body: some View {
        VStack {
            CardView(title: "Card 1", description: "First card")
            CardView(title: "Card 2", description: "Second card")
        }
    }
}

#Preview {
    CardsView()
}
