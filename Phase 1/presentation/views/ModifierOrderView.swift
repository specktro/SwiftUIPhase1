//
//  ModifierOrderView.swift
//  Phase 1
//
//  Created by specktro on 25/11/25.
//

import SwiftUI

struct ModifierOrderView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Padding First")
                .padding()
                .background(Color.blue)
            Text("Background First")
                .background(Color.blue)
                .padding()
        }
    }
}

#Preview {
    ModifierOrderView()
}
