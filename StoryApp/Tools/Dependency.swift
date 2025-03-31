//
//  Dependency.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

class Dependency<T: Sendable>: ObservableObject {
    let dependencyObject: T
    
    init(dependencyObject: T) {
        self.dependencyObject = dependencyObject
    }
}

extension EnvironmentValues {
    @Entry var userRepository: Dependency<UserRepository> = Dependency(dependencyObject: JsonUserRepository())
    @Entry var storyRepository: Dependency<StoryRepository> = Dependency(dependencyObject: JsonStoryRepository())
}
