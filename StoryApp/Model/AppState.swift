//
//  AppState.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

enum AppState<T> {
    case loading
    case ready(T)
    case error(String)
}
