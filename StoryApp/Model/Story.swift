//
//  Story.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

struct Story {
    let id: Int
    let userId: Int
    let assetURL: URL?
    let isFavorite: Bool
}

extension Story {
    static let mockStories: [Story] = [
        .init(
            id: 0,
            userId: 0,
            assetURL: .init(string: "https://picsum.photos/id/100/200/300"),
            isFavorite: true
        ),
        .init(
            id: 1,
            userId: 0,
            assetURL: .init(string: "https://picsum.photos/id/200/200/300"),
            isFavorite: false
        ),
        .init(
            id: 2,
            userId: 0,
            assetURL: .init(string: "https://picsum.photos/id/300/200/300"),
            isFavorite: true
        ),
        .init(
            id: 3,
            userId: 0,
            assetURL: .init(string: "https://picsum.photos/id/400//200/300"),
            isFavorite: false
        )
    ]
}
