//
//  HackerNewsViewModel.swift
//  Phase 1
//
//  Created by specktro on 25/12/25.
//

import Foundation
import SwiftUI

@MainActor @Observable class HackerNewsViewModel {
    // MARK: - Published State
    var state: LoadingState<[Story]> = .idle
    
    // MARK: - Dependencies
    private let api = HackerNewsAPI()
    
    // MARK: - Actions
    func loadTopStories() async {
        // Set loading state
        state = .loading
        
        do {
            // 1. Fetch story IDs
            let ids = try await api.fetchTopStories(limit: 30)
            
            // 2. Fetch stories
            let stories = try await api.fetchStories(ids: ids)
            
            // 3. Sort by score (highest first)
            let sortedStories = stories.sorted {
                ($0.score ?? 0) > ($1.score ?? 0)
            }
            
            // 4. Update state
            state = .success(sortedStories)
            
        } catch {
            // Handle error
            state = .failure(error)
        }
    }
}
