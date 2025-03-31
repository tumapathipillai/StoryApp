//
//  JsonStoryRepository.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation
import OSLog

// MARK: - Models for decoding datas
fileprivate struct JsonStory: Decodable {
    let id: Int
    let userId: Int
    let assetURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case assetURL = "asset_url"
    }
}

final actor JsonStoryRepository: StoryRepository {
    private static let isFavoriteStorageKey = "isFavorite"
    private let logger = Logger(subsystem: "story.app", category: "JsonStoryRepository")

    func getStories(of user: Int) async throws -> [Story] {
        guard let fileURL = Bundle.main.url(forResource: "story_data", withExtension: "json") else {
            logger.error("Story file not found")
            throw AppError.internalError
        }
        
        let data = try Data(contentsOf: fileURL)
        
        let jsonStories = try JSONDecoder().decode([JsonStory].self, from: data)
        
        return try mapJsonStoryToStory(jsonStories.filter { $0.userId == user })
    }
    
    private func mapJsonStoryToStory(_ jsonStories: [JsonStory]) throws -> [Story] {
        try jsonStories.map { jsonStory in
            let isFavorite: Bool = try isFavorite(storyId: jsonStory.id)
            
            return Story(
                id: jsonStory.id,
                userId: jsonStory.userId,
                assetURL: jsonStory.assetURL,
                isFavorite: isFavorite
            )
        }
    }
    
    private func isFavorite(storyId: Int) throws -> Bool {
        let userDefaults = UserDefaults.standard
        
        if let favoriteStoriesData = userDefaults.array(forKey: Self.isFavoriteStorageKey) {
            guard let favoriteStories = favoriteStoriesData as? [Int] else {
                logger.error("Failed to map favorite stories data to [Int]")
                throw AppError.internalError
            }
            
            return favoriteStories.contains(storyId)
        } else {
            return false
        }
    }
    
    func updateFavoriteState(of storyId: Int, newState: Bool) async throws {
        let userDefaults = UserDefaults.standard
        
        if let favoriteStoriesData = userDefaults.array(forKey: Self.isFavoriteStorageKey) {
            guard var favoriteStories = favoriteStoriesData as? [Int] else {
                logger.error("Failed to map favorite stories data to [Int]")
                throw AppError.internalError
            }
            
            if newState, !favoriteStories.contains(storyId) {
                favoriteStories.append(storyId)
            }
            
            if !newState {
                favoriteStories.removeAll(where: { $0 == storyId })
            }
            
            userDefaults.set(favoriteStories, forKey: Self.isFavoriteStorageKey)
        } else {
            if newState {
                userDefaults.set([storyId], forKey: Self.isFavoriteStorageKey)
            }
        }
    }
}
