//
//  StateMachineDemoView.swift
//  Phase 1
//
//  Created by specktro on 21/12/25.
//


import SwiftUI

// MARK: - Example View
struct StateMachineDemoView: View {
    @StateObject var viewModel = ExampleViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("State Machine Demo")
                .font(.title)
            
            // TODO: Display based on state
            switch viewModel.state {
            case .idle:
                Text("Press button to load")
                
            case .loading:
                ProgressView()
                Text("Loading...")
                
            case .success(let items):
                List(items, id: \.self) { item in
                    Text(item)
                }
                
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            Button("Load Data") {
                Task {
                    await viewModel.loadData()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    StateMachineDemoView()
}
