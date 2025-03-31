//
//  UserRepository.swift
//  StoryApp
//
//  Created by Thileepan Umapathipillai on 31/03/2025.
//

import Foundation

protocol UserRepository: Actor {
    func getUsers(page: Int, limit: Int) async throws -> [User]
    func readStories(of userId: Int) async throws
}
