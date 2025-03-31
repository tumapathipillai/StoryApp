//
//  ContentView.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.userRepository) private var userRepository

    var body: some View {
        VStack {
            StoryList(viewModel: .init(userRepository: userRepository.dependencyObject))
                .padding(.leading, 10)
                .frame(height: 150)
            Color.gray
        }
    }
}

#Preview {
    ContentView()
}
