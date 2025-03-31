//
//  InfiniteScrollView.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct InfiniteScrollView<T: Identifiable, ContentView: View, ErrorView: View>: View {
    let items: [T]
    let loadMore: (() async -> Void)?
    let error: Error?
    let contentView: (T) -> ContentView
    let errorView: (Error) -> ErrorView
    
    init(
        items: [T],
        loadMore: (() async -> Void)? = nil,
        error: Error? = nil,
        contentView: @escaping (T) -> ContentView,
        errorView: @escaping (Error) -> ErrorView
    ) {
        self.items = items
        self.loadMore = loadMore
        self.error = error
        self.contentView = contentView
        self.errorView = errorView
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(items) { item in
                    contentView(item)
                }
                
                if let error {
                    errorView(error)
                } else if let loadMore {
                    ProgressView()
                        .task {
                            await loadMore()
                        }
                }
            }
        }
    }
}

#Preview {
    InfiniteScrollView(items: User.mockUsers, loadMore: {}) { user in
        Text(user.name)
    } errorView: { error in
        Text(error.localizedDescription)
    }
}
