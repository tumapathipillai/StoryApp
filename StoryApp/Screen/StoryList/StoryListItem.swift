//
//  StoryListItem.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct StoryListItem: View {
    let user: User
    
    var stateColor: Color {
        switch user.storiesState {
        case .empty:
            return .clear
        case .new:
            return .green
        case .read:
            return .gray
        }
    }

    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: user.profilePictureURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .padding(5)
                Circle()
                    .stroke(stateColor, lineWidth: 3)
            }
            .frame(width: 100, height: 100)
            Text(user.name)
                .bold()
        }
    }
}

#Preview {
    StoryListItem(
        user: .init(
            id: 0,
            name: "Lorem Ipsum 0",
            profilePictureURL: .init(string: "https://picsum.photos/id/0/200/200"),
            storiesState: .new
        )
    )
}
