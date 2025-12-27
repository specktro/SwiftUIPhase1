//
//  HackerNewsView.swift
//  Phase 1
//
//  Created by specktro on 25/12/25.
//

import SwiftUI

struct HackerNewsView: View {
    @State private var viewModel = HackerNewsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Switch on state
                switch viewModel.state {
                case .idle:
                    idleView
                    
                case .loading:
                    loadingView
                    
                case .success(let stories):
                    successView(stories: stories)
                    
                case .failure(let error):
                    errorView(error: error)
                }
            }
            .navigationTitle("Top Stories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    refreshButton
                }
            }
            .task {
                // Load when view appears
                await viewModel.loadTopStories()
            }
        }
    }
    
    // MARK: - Idle View
    private var idleView: some View {
        ContentUnavailableView(
            "Hacker News",
            systemImage: "newspaper",
            description: Text("Tap refresh to load stories")
        )
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Loading top stories...")
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Success View
    private func successView(stories: [Story]) -> some View {
        List(stories) { story in
            StoryRow(story: story)
        }
        .refreshable {
            await viewModel.loadTopStories()
        }
    }
    
    // MARK: - Error View
    private func errorView(error: Error) -> some View {
        ContentUnavailableView {
            Label("Error", systemImage: "exclamationmark.triangle")
        } description: {
            Text(error.localizedDescription)
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.loadTopStories()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    // MARK: - Refresh Button
    private var refreshButton: some View {
        Button {
            Task {
                await viewModel.loadTopStories()
            }
        } label: {
            Image(systemName: "arrow.clockwise")
        }
    }
}

// MARK: - Story Row
struct StoryRow: View {
    let story: Story
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(story.title)
                .font(.headline)
                .lineLimit(3)
            
            // Metadata
            HStack(spacing: 12) {
                // Score
                if let score = story.score {
                    Label("\(score)", systemImage: "arrow.up")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                
                // Author
                if let by = story.by {
                    Text("by \(by)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Time
                Text(story.timeAgo)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
#Preview {
    HackerNewsView()
}
