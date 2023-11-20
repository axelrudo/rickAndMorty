//
//  CharactersUseCaseFake.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

final class CharactersUseCaseFake: CharacterUseCaseProtocol {

    var networkError: NetworkError?

    func loadFavoriteCharacters() async throws -> [Character] {
        if let networkError {
            throw networkError
        }

        return [Character.mock]
    }

    func saveCharacter(character: Character) async throws {
        if let networkError {
            throw networkError
        }
    }

    func removeCharacter(character: Character) async throws {
        if let networkError {
            throw networkError
        }
    }

    func loadUpdatedCharacters(characters: [Character]) async throws -> [Character] {
        if let networkError {
            throw networkError
        }

        return [Character.mock]
    }

    func loadCharacters(of page: Int, with name: String) async throws -> Pagination<Character> {
        if let networkError {
            throw networkError
        }

        return Pagination<Character>(
            results: [Character.mock],
            hasNextPage: true)
    }

    func loadCharacters(of page: Int) async throws -> Pagination<Character> {
        if let networkError {
            throw networkError
        }

        return Pagination<Character>(
            results: [Character.mock],
            hasNextPage: true)
    }
}
