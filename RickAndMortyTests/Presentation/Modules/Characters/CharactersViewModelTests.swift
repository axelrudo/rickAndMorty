//
//  CharactersViewModelTests.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import XCTest
@testable import RickAndMorty

final class CharactersViewModelTests: XCTestCase {

    var sut: CharactersViewModel!
    var router: CharactersRouterFake!
    var useCase: CharactersUseCaseFake!

    private func customSetup() {
        router = CharactersRouterFake()
        useCase = CharactersUseCaseFake()
        sut = CharactersViewModel(router: router, useCase: useCase)
    }

    private func customTearDown() {
        router = nil
        useCase = nil
        sut = nil
    }

    func test_whenViewReady_thenSuccessResponse() {
        customSetup()

        // Then
        sut.didDataLoaded = {
            XCTAssertEqual(self.sut.characters.count, 1)
            self.customTearDown()
        }

        // When
        sut.viewReady()
    }

    func test_whenViewReady_thenFailureResponse() {
        customSetup()

        // Given
        useCase.networkError = .badURL

        // Then
        sut.didResponseFailed = { message in
            XCTAssertEqual(message, NetworkError.badURL.localizedDescription)
            self.customTearDown()
        }

        // When
        sut.viewReady()
    }

    func test_whenGoToCharactersDetail_thenViewLoaded() {
        customSetup()

        // Given
        sut.characters = [Character.mock]

        // When
        sut.goToCharacterDetail(of: 0)

        // Then
        XCTAssert(router.characterDetailCalled)
        customTearDown()

    }
}
