//
//  JsonUserRepository.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation
import OSLog

// MARK: - Models for decoding datas
fileprivate struct JsonUser: Decodable {
    let id: Int
    let name: String
    let profilePictureURL: URL?
    let hasStories: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePictureURL = "profile_picture_url"
        case hasStories = "has_stories"
    }
}

final actor JsonUserRepository: UserRepository {
    private static let seenStoriesStorageKey = "seenStories"
    private let logger = Logger(subsystem: "story.app", category: "JsonUserRepository")

    func getUsers(page: Int, limit: Int) async throws -> [User] {
        guard let fileURL = Bundle.main.url(forResource: "user_data", withExtension: "json") else {
            logger.error("User file not found")
            throw AppError.internalError
        }
        
        let data = try Data(contentsOf: fileURL)
        
        let jsonUsers = try JSONDecoder().decode([JsonUser].self, from: data)
        
        let minRange: Int = page * limit
        let maxRange: Int = min(jsonUsers.count, (page + 1) * limit)

        if minRange > maxRange {
            return []
        }
                
        return try mapJsonUserToUser(Array(jsonUsers[minRange..<maxRange]))
    }
    
    private func mapJsonUserToUser(_ jsonUsers: [JsonUser]) throws -> [User] {
        try jsonUsers.map { jsonUser in
            let storyState: UserStoryState
            
            if jsonUser.hasStories {
                let hasSeenStory = try hasSeenStories(of: jsonUser.id)
                
                storyState = hasSeenStory ? .read : .new
            } else {
                storyState = .empty
            }
            
            return User(
                id: jsonUser.id,
                name: jsonUser.name,
                profilePictureURL: jsonUser.profilePictureURL,
                storiesState: storyState
            )
        }
    }
    
    private func hasSeenStories(of userId: Int) throws -> Bool {
        let userDefaults = UserDefaults.standard
        
        if let seenStoriesData = userDefaults.array(forKey: Self.seenStoriesStorageKey) {
            guard let seenStories = seenStoriesData as? [Int] else {
                logger.error("Failed to map seen stories data to [Int]")
                throw AppError.internalError
            }
            
            return seenStories.contains(userId)
        } else {
            return false
        }
    }
    
    func readStories(of userId: Int) async throws {
        let userDefaults = UserDefaults.standard
        
        if let seenStoriesData = userDefaults.array(forKey: Self.seenStoriesStorageKey) {
            guard var seenStories = seenStoriesData as? [Int] else {
                logger.error("Failed to map seen stories data to [Int]")
                throw AppError.internalError
            }
            
            if !seenStories.contains(userId) {
                seenStories.append(userId)
            }

            userDefaults.set(seenStories, forKey: Self.seenStoriesStorageKey)
        } else {
            userDefaults.set([userId], forKey: Self.seenStoriesStorageKey)
        }
    }
}
