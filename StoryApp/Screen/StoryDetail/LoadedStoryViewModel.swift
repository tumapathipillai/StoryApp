//
//  LoadedStoryViewModel.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

@Observable
final class LoadedStoryViewModel {
    private(set) var stories: [Story]
    private(set) var currentIndex: Int = 0
    let storyRepository: StoryRepository
    
    var currentStory: Story {
        stories[currentIndex]
    }
    
    init(stories: [Story], storyRepository: StoryRepository) {
        self.stories = stories
        self.storyRepository = storyRepository
    }
    
    func goToNextStory() {
        if currentIndex < stories.count - 1 {
            currentIndex += 1
        }
    }
    
    func goToPreviousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func updateFavorite(_ isFavorite: Bool) {
        Task {
            try await storyRepository.updateFavoriteState(of: currentStory.id, newState: isFavorite)
        }
        
        stories[currentIndex] = .init(
            id: currentStory.id,
            userId: currentStory.userId,
            assetURL: currentStory.assetURL,
            isFavorite: isFavorite
        )
    }
}
