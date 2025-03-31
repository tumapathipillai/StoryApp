//
//  StoryListViewModel.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

@Observable
final class StoryListViewModel {
    private(set) var loadedUsers: [User] = []
    private(set) var canLoadMore: Bool = true
    private(set) var error: Error? = nil
    private(set) var isLoading: Bool = false
    private var page: Int = 0
    
    var showStoryDetail: User? = nil

    let userRepository: UserRepository
    private static let pageSize: Int = 10
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func loadUsers() async {
        if !isLoading {
            await MainActor.run {
                self.isLoading = true
            }

            do {
                let users = try await userRepository.getUsers(page: page, limit: Self.pageSize)
                
                if users.isEmpty {
                    await MainActor.run {
                        self.canLoadMore = false
                    }
                }
                
                await MainActor.run {
                    self.page += 1
                    
                    loadedUsers.append(contentsOf: users)
                    
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = error
                    
                    self.isLoading = false
                }
            }
        }
    }
    
    func retry() {
        error = nil
    }
    
    func showDetail(for user: User) {
        Task {
           try await userRepository.readStories(of: user.id)
        }
        if let index = loadedUsers.firstIndex(where: { user.id == $0.id }) {
            let oldUser = loadedUsers[index]
            loadedUsers[index] = .init(
                id: oldUser.id,
                name: oldUser.name,
                profilePictureURL: oldUser.profilePictureURL,
                storiesState: .read
            )
        }
        
        showStoryDetail = user
    }
}
