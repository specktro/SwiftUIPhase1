//
//  ModifierOrderView.swift
//  Phase 1
//
//  Created by specktro on 25/11/25.
//

import SwiftUI

// TODO: Add this to show modifier order matters
struct ModifierOrderDemo: View {
    var body: some View {
        VStack(spacing: 40) {
            // Example showing padding→background
            Text("Padding First")
                .padding()
                .background(Color.blue)
            
            // Example showing background→padding
            Text("Background First")
                .background(Color.blue)
                .padding()
        }
    }
}

#Preview {
    ModifierOrderDemo()
}
