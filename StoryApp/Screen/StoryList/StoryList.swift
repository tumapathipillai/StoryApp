//
//  StoryList.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct StoryList: View {
    @State private var viewModel: StoryListViewModel
    @Environment(\.storyRepository) var storyRepository
    
    init(viewModel: StoryListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        InfiniteScrollView(
            items: viewModel.loadedUsers,
            loadMore: viewModel.canLoadMore ? viewModel.loadUsers : nil,
            error: viewModel.error
        ) { user in
            StoryListItem(user: user)
                .onTapGesture {
                    if user.storiesState != .empty {
                        viewModel.showDetail(for: user)                        
                    }
                }
        } errorView: { error in
            Button {
                viewModel.retry()
            } label: {
                Image(systemName: "arrow.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundStyle(.black)
            }
        }
        .fullScreenCover(item: $viewModel.showStoryDetail) { user in
            StoryDetailView(
                viewModel: .init(
                    storyRepository: storyRepository.dependencyObject,
                    userId: user.id
                )
            )
        }
    }
}

#Preview {
    StoryList(viewModel: .init(userRepository: JsonUserRepository()))
}
