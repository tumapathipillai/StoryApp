//
//  StoryRepository.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

protocol StoryRepository: Actor {
    func getStories(of user: Int) async throws -> [Story]
    func updateFavoriteState(of storyId: Int, newState: Bool) async throws
}
