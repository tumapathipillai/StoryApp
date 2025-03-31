//
//  User.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

enum UserStoryState {
    case empty
    case new
    case read
}

struct User {
    let id: Int
    let name: String
    let profilePictureURL: URL?
    let storiesState: UserStoryState
}

extension User: Identifiable {}

extension User {
    static let mockUsers: [User] = [
        .init(
            id: 0,
            name: "Lorem Ipsum 0",
            profilePictureURL: .init(string: "https://picsum.photos/id/0/200/200"),
            storiesState: .empty
        ),
        .init(
            id: 1,
            name: "Lorem Ipsum 1",
            profilePictureURL: .init(string: "https://picsum.photos/id/1/200/200"),
            storiesState: .new
        ),
        .init(
            id: 2,
            name: "Lorem Ipsum 2",
            profilePictureURL: .init(string: "https://picsum.photos/id/2/200/200"),
            storiesState: .read
        )
    ]
}
