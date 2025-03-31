//
//  StoryDetailView.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct StoryDetailView: View {
    @State private var viewModel: StoryDetailViewModel
    @Environment(\.storyRepository) var storyRepository
    
    init(viewModel: StoryDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .task {
                    await viewModel.loadStories()
                }
            case .ready(let stories):
                LoadedStoryView(
                    viewModel: .init(
                        stories: stories,
                        storyRepository: storyRepository.dependencyObject
                    )
                )
            case .error(let error):
                VStack {
                    Spacer()
                    Text(error)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(.black)
    }
}

#Preview {
    StoryDetailView(
        viewModel: .init(
            storyRepository: JsonStoryRepository(),
            userId: 1
        )
    )
}
