//
//  CharacterMock.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

extension Character {
    static let mock = Character(dto: CharacterDTO.mock)
    static let mockWithImage = Character(dto: CharacterDTO.mockWithImage)
}
