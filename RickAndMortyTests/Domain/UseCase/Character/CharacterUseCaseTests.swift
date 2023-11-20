//
//  CharacterUseCaseTests.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import XCTest
@testable import RickAndMorty

final class CharacterUseCaseTests: XCTestCase {

    var sut: CharacterUseCase!
    var repository: CharacterRepositoryFake!
    
    override func setUp() {
        super.setUp()

        repository = CharacterRepositoryFake()
        sut = CharacterUseCase(repository: repository)
    }

    override func tearDown() {
        super.tearDown()

        repository = nil
        sut = nil
    }

    func test_whenLoadCharacters_thenSuccessResponse() async {
        do {
            // When
            let response = try await sut.loadCharacters(of: 1)

            // Then
            let char = response.results.first
            XCTAssertEqual(char?.id, 1)
        } catch {
            XCTFail("Expected success response")
        }
    }

    func test_whenLoadCharactersWithParam_thenSuccessResponse() async {
        do {
            // When
            let response = try await sut.loadCharacters(of: 1, with: "query")

            // Then
            let char = response.results.first
            XCTAssertEqual(char?.id, 1)
        } catch {
            XCTFail("Expected success response")
        }
    }

    func test_whenLoadCharactersWithParam_thenEmptyResponse() async {
        do {
            // When
            let response = try await sut.loadCharacters(of: 1, with: "")

            // Then
            let count = response.results.count
            XCTAssertEqual(count, 0)
        } catch {
            XCTFail("Expected success response")
        }
    }
}
