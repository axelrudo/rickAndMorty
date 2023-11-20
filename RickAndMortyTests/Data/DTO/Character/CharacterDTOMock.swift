//
//  CharacterDTOMock.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

extension CharacterDTO {
    static let mock = CharacterDTO(id: 1)
    static let mockWithImage = CharacterDTO(id: 2, image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
}
