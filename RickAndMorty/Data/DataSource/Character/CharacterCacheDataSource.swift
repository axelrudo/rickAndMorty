//
//  CharacterCacheDataSource.swift
//  RickAndMorty
//
//  Created by axel on 9/8/23.
//

import Foundation

protocol CharacterCacheDataSourceProtocol {
    func saveCharacter(character: Character) async throws
    func loadFavoriteCharacters() async throws -> [Character]
    func removeCharacter(character: Character) async throws
}

final class CharacterCacheDataSource {
    private let cache: CacheProtocol

    init(cache: CacheProtocol = Cache()) {
        self.cache = cache
    }
}

extension CharacterCacheDataSource: CharacterCacheDataSourceProtocol {
    func saveCharacter(character: Character) async throws {
        var favorites = try await loadFavoriteCharacters()
        favorites.append(character)
        let favoritesDTO = favorites.compactMap { CharacterDTO(entity: $0) }
        try await cache.save(object: favoritesDTO, for: "favorites", of: [CharacterDTO].self)
    }

    func loadFavoriteCharacters() async throws -> [Character] {
        let favorites = try await cache.load(for: "favorites", of: [CharacterDTO].self)
        return favorites?.compactMap {
            var char = Character(dto: $0)
            char.isFavorite = true
            return char
        } ?? []
    }

    func removeCharacter(character: Character) async throws {
        let favorites = try await loadFavoriteCharacters()
        let favoritesDTO = favorites
            .filter { $0.id != character.id }
            .compactMap { CharacterDTO(entity: $0) }

        try await cache.save(object: favoritesDTO, for: "favorites", of: [CharacterDTO].self)
    }
}
