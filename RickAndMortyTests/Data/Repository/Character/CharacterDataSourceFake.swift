//
//  CharacterDataSourceFake.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

final class CharacterDataSourceFake: CharacterDataSourceProtocol {

    var networkError: NetworkError?

    func loadCharacters(with query: String) async throws -> Pagination<Character> {
        if let networkError {
            throw networkError
        }

        return Pagination<Character>(results: [Character.mock])
    }
}
