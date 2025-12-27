//
//  HackerNewsModels.swift
//  Phase 1
//
//  Created by specktro on 25/12/25.
//

import Foundation

// MARK: - Story Model
struct Story: Identifiable, Equatable, nonisolated Codable {
    let id: Int
    let title: String
    let by: String?
    let score: Int?
    let time: Int?
    let url: String?
    let text: String?
    
    // Computed property for user-friendly time
    var timeAgo: String {
        guard let time = time else { return "Unknown" }
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    // For preview/testing
    static var example: Story {
        Story(
            id: 1,
            title: "Example Hacker News Story",
            by: "testuser",
            score: 100,
            time: Int(Date().timeIntervalSince1970),
            url: "https://example.com",
            text: nil
        )
    }
}
