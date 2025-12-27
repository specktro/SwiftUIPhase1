//
//  HackerNewsAPI.swift
//  Phase 1
//
//  Created by specktro on 25/12/25.
//

import Foundation

// MARK: - API Error
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode data"
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Hacker News API
actor HackerNewsAPI {
    private let baseURL = "https://hacker-news.firebaseio.com/v0"
    
    // MARK: - Fetch Top Story IDs
    func fetchTopStories(limit: Int = 30) async throws -> [Int] {
        // TODO: Implement
        // 1. Build URL for /topstories.json
        guard let url = URL(string: "\(baseURL)/topstories.json") else {
            throw APIError.invalidURL
        }
        // 2. Fetch data with URLSession
        let (data, response) = try await URLSession.shared.data(from: url)
        // 3. Decode to [Int]
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        // 4. Return first 'limit' items
        do {
            let allIDs = try JSONDecoder().decode([Int].self, from: data)
            return Array(allIDs.prefix(limit))
        } catch {
            throw APIError.decodingError
        }
    }
    
    // MARK: - Fetch Single Story
    func fetchStory(id: Int) async throws -> Story {
        // TODO: Implement
        // 1. Build URL for /item/{id}.json
        guard let url = URL(string: "\(baseURL)/item/\(id).json") else {
            throw APIError.invalidURL
        }
        // 2. Fetch data with URLSession
        let (data, response) = try await URLSession.shared.data(from: url)
        // 3. Decode to Story
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        // 4. Return story
        do {
            return try JSONDecoder().decode(Story.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    // MARK: - Fetch Multiple Stories (Parallel)
    func fetchStories(ids: [Int]) async throws -> [Story] {
        // TODO: Implement parallel fetching
        // Use TaskGroup for best performance
        try await withThrowingTaskGroup(of: Story.self) { group in
            for id in ids {
                group.addTask {
                    try await self.fetchStory(id: id)
                }
            }
            // Collect stories
            var stories: [Story] = []
            for try await story in group {
                stories.append(story)
            }
            return stories
        }
    }
}

#if DEBUG
extension HackerNewsAPI {
    static func test() async {
        let api = HackerNewsAPI()
        
        do {
            print("Fetching top stories...")
            let ids = try await api.fetchTopStories(limit: 5)
            print("Got \(ids.count) IDs: \(ids)")
            
            print("\nFetching stories...")
            let stories = try await api.fetchStories(ids: ids)
            print("Got \(stories.count) stories:")
            for story in stories {
                print("- \(story.title)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
#endif
