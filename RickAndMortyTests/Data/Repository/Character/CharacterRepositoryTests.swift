//
//  CharacterRepositoryTests.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import XCTest
@testable import RickAndMorty

final class CharacterRepositoryTests: XCTestCase {

    var dataSource: CharacterDataSourceFake!
    var sut: CharacterRepository!

    override func setUp() {
        super.setUp()

        dataSource = CharacterDataSourceFake()
        sut = CharacterRepository(dataSource: dataSource)
    }

    override func tearDown() {
        super.tearDown()

        dataSource = nil
        sut = nil
    }

    func test_whenLoadCharacters_thenSuccessResponse() async {

        // When
        do {
            let result = try await sut.loadCharacters(with: "query")

            // Then
            XCTAssert(result.results.count == 1)
        } catch {
            XCTFail("Expected success response")
        }
    }
}
