//
//  ExampleViewModel.swift
//  Phase 1
//
//  Created by specktro on 21/12/25.
//

import Combine
import Foundation

// MARK: - Example ViewModel
@MainActor
class ExampleViewModel: ObservableObject {
    @Published var state: LoadingState<[String]> = .idle
    
    func loadData() async {
        state = .loading
        
        do {
            try await Task.sleep(for: .seconds(2))
            
            if Bool.random() {
                throw URLError(.badServerResponse)
            }
            
            state = .success(["Item 1", "Item 2", "Item 3"])
        } catch {
            state = .failure(error)
        }
    }
}
