//
//  CharactersRouterFake.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import Foundation
@testable import RickAndMorty

final class CharactersRouterFake: CharactersRouterProtocol {
    private(set) var characterDetailCalled = false

    func characterDetail(of character: Character) {
        characterDetailCalled = true
    }
}
