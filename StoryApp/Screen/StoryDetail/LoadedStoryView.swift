//
//  LoadedStoryView.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct LoadedStoryView: View {
    let viewModel: LoadedStoryViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: LoadedStoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.black
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    AsyncImage(url: viewModel.currentStory.assetURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                        .tint(.white)
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture { location in
                    if location.x > proxy.size.width / 2 {
                        viewModel.goToNextStory()
                    } else {
                        viewModel.goToPreviousStory()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Spacer()
                Button {
                    viewModel.updateFavorite(!viewModel.currentStory.isFavorite)
                } label: {
                    Image(systemName: viewModel.currentStory.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .foregroundStyle(.white)
            .padding(20)
        }
    }
}

#Preview {
    LoadedStoryView(
        viewModel: .init(
            stories: Story.mockStories,
            storyRepository: JsonStoryRepository()
        )
    )
}
