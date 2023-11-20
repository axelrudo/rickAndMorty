//
//  CharacterDataSource.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

protocol CharacterDataSourceProtocol {
    func loadCharacters(with query: String) async throws -> Pagination<Character>
}

final class CharacterDataSource {
    private let network: NetworkProtocol

    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
}

extension CharacterDataSource: CharacterDataSourceProtocol {
    func loadCharacters(with query: String) async throws -> Pagination<Character> {
        let result = try await network.load(
            path: CharacterEndpoints.characters(query).path,
            of: PaginationDTO<CharacterDTO>.self
        )

        return Pagination<Character>(
            results: result.results?.compactMap { Character(dto: $0) } ?? [],
            hasNextPage: result.info?.next != nil
        )
    }
}

enum CharacterEndpoints {
    case characters(String)

    var path: String {
        switch self {
        case .characters(let query):
            return Constants.baseURL + "character/\(query)"
        }
    }
}
