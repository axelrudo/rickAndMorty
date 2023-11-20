//
//  CharacterRepositoryFake.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

final class CharacterRepositoryFake: CharacterRepositoryProtocol {

    var networkError: NetworkError?

    func saveCharacter(character: Character) async throws {
        if let networkError {
            throw networkError
        }
    }

    func loadFavoriteCharacters() async throws -> [Character] {
        if let networkError {
            throw networkError
        }

        return [Character.mock]
    }

    func removeCharacter(character: Character) async throws {
        if let networkError {
            throw networkError
        }
    }

    func loadCharacters(with query: String) async throws -> Pagination<Character> {
        if let networkError {
            throw networkError
        }
        let results = query.last == "=" ? [] : [Character.mock]

        return Pagination<Character>(results: results)
    }
}
