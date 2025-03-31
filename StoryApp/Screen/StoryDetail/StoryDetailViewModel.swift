//
//  StoryDetailViewModel.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

@Observable
final class StoryDetailViewModel {
    private(set) var state: AppState<[Story]> = .loading
    private let storyRepository: StoryRepository
    private let userId: Int
    
    init(storyRepository: StoryRepository, userId: Int) {
        self.storyRepository = storyRepository
        self.userId = userId
    }
    
    func loadStories() async {
        await updateState(.loading)
        
        do {
            let stories = try await storyRepository.getStories(of: userId)
            
            await updateState(.ready(stories))
        } catch {
            await updateState(.error(error.localizedDescription))
        }
    }
    
    @MainActor
    func updateState(_ newState: AppState<[Story]>) {
        self.state = newState
    }
}
