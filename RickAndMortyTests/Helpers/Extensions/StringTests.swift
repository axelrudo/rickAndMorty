//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyTests: XCTestCase {

    func test_string() {
        let rest = "alert_error_ok".localized

        XCTAssert(rest == "Aceptar")

    }
}

