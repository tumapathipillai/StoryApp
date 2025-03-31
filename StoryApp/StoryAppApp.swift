//
//  StoryAppApp.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

@main
struct StoryAppApp: App {
    let userRepository: UserRepository = JsonUserRepository()
    let storyRepository: StoryRepository = JsonStoryRepository()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.userRepository, .init(dependencyObject: userRepository))
                .environment(\.storyRepository, .init(dependencyObject: storyRepository))
        }
    }
}
