//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func loadCharacters(with query: String) async throws -> Pagination<Character>
    func saveCharacter(character: Character) async throws
    func loadFavoriteCharacters() async throws -> [Character]
    func removeCharacter(character: Character) async throws
}

final class CharacterRepository {
    var dataSource: CharacterDataSourceProtocol
    var cacheDataSource: CharacterCacheDataSourceProtocol

    init(dataSource: CharacterDataSourceProtocol = CharacterDataSource(),
         cacheDataSource: CharacterCacheDataSourceProtocol = CharacterCacheDataSource()) {
        self.dataSource = dataSource
        self.cacheDataSource = cacheDataSource
    }
}

extension CharacterRepository: CharacterRepositoryProtocol {
    func saveCharacter(character: Character) async throws {
        try await cacheDataSource.saveCharacter(character: character)
    }

    func loadFavoriteCharacters() async throws -> [Character] {
        try await cacheDataSource.loadFavoriteCharacters()
    }

    func removeCharacter(character: Character) async throws {
        try await cacheDataSource.removeCharacter(character: character)
    }

    func loadCharacters(with query: String) async throws -> Pagination<Character> {
        try await dataSource.loadCharacters(with: query)
    }
}
