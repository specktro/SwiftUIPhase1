//
//  BasicView.swift
//  Phase 1
//
//  Created by specktro on 23/11/25.
//

import SwiftUI

struct BasicView: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI")
                .font(.title)
                .foregroundColor(.blue)
            
            Image(systemName: "star.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            
            Button("Tap Me") {
                print("Button tapped")
            }
        }
    }
}

#Preview {
    BasicView()
}
