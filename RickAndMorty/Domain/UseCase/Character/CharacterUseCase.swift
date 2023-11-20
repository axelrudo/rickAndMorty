//
//  CharacterUseCase.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

protocol CharacterUseCaseProtocol {
    func loadCharacters(of page: Int) async throws -> Pagination<Character>
    func loadCharacters(of page: Int, with name: String) async throws -> Pagination<Character>
    func loadFavoriteCharacters() async throws -> [Character]
    func saveCharacter(character: Character) async throws
    func removeCharacter(character: Character) async throws
    func loadUpdatedCharacters(characters: [Character]) async throws -> [Character]
}

final class CharacterUseCase {
    var repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
    }
}

extension CharacterUseCase: CharacterUseCaseProtocol {

    func loadCharacters(of page: Int, with name: String) async throws -> Pagination<Character> {
        let formattedName = name.split(separator: " ").first ?? ""

        let query = "?page=\(page)&name=\(formattedName)"

        return try await repository.loadCharacters(with: query)
    }

    func loadCharacters(of page: Int) async throws -> Pagination<Character> {
        let query = "?page=\(page)"
        var characters = try await repository.loadCharacters(with: query)
        let updatedCharacters = try await loadUpdatedCharacters(characters: characters.results)
        characters.results = updatedCharacters
        return characters
    }

    func loadFavoriteCharacters() async throws -> [Character] {
        try await repository.loadFavoriteCharacters()
    }

    func saveCharacter(character: Character) async throws {
        try await repository.saveCharacter(character: character)
    }

    func removeCharacter(character: Character) async throws {
        try await repository.removeCharacter(character: character)
    }

    func loadUpdatedCharacters(characters: [Character]) async throws -> [Character] {
        let favorites = try await loadFavoriteCharacters()

        var updatedCharacters = [Character]()

        characters.forEach { character in
            var aux = character
            aux.isFavorite = favorites.contains(where: { $0.id == character.id })
            updatedCharacters.append(aux)
        }
        return updatedCharacters
    }
}
