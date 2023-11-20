//
//  CharacterDataSourceTests.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import XCTest
@testable import RickAndMorty

final class CharacterDataSourceTests: XCTestCase {

    var network: NetworkFake<PaginationDTO<CharacterDTO>>!
    var sut: CharacterDataSource!

    override func setUp() {
        super.setUp()

        network = NetworkFake()
        sut = CharacterDataSource(network: network)
    }

    override func tearDown() {
        super.tearDown()

        network = nil
        sut = nil
    }

    func test_whenLoadCharacters_thenSuccessResponse() async {

        // Given
        let response = PaginationDTO<CharacterDTO>(results: [CharacterDTO.mock])
        network.response = response

        // When
        do {
            let response = try await sut.loadCharacters(with: "query")

            // Then
            XCTAssert(response.results.count == 1)
        } catch {
            XCTFail("Expected success response")
        }
    }

    func test_whenLoadCharacters_thenSuccessEmptyResponse() async {

        // Given
        let response = PaginationDTO<CharacterDTO>(results: [])
        network.response = response

        // When
        do {
            let response = try await sut.loadCharacters(with: "query")

            // Then
            XCTAssert(response.results.count == 0)
        } catch {
            XCTFail("Expected success response")
        }
    }

    func test_whenLoadCharacters_thenSuccessNilResponse() async {

        // Given
        let response = PaginationDTO<CharacterDTO>(results: nil)
        network.response = response

        // When
        do {
            let response = try await sut.loadCharacters(with: "query")

            // Then
            XCTAssert(response.results.count == 0)
        } catch {
            XCTFail("Expected success response")
        }
    }

}
