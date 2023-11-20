////
////  CharactersTableViewCellTests.swift
////  RickAndMortyTests
////
////  Created by axel on 31/7/23.
////
//
//import XCTest
//@testable import RickAndMorty
//import UIKit
//
//final class CharactersTableViewCellTests: XCTestCase {
//
//    var nameLabel: UILabel!
//    var idLabel: UILabel!
//    var characterImage: UIImageView!
//    var manager: ImageDownloaderManagerFake!
//    var sut: CharactersTableViewCell!
//
//    var speciesLabel: UILabel!
//    var locationLabel: UILabel!
//    var stackView: UIStackView!
//
//    override func setUp() {
//        super.setUp()
//
//        nameLabel = UILabel()
//        characterImage = UIImageView()
//        manager = ImageDownloaderManagerFake()
//        stackView = UIStackView()
//        speciesLabel = UILabel()
//        locationLabel = UILabel()
//        sut = CharactersTableViewCell()
//
//        sut.characterImage = characterImage
//        sut.nameLabel = nameLabel
//        sut.manager = manager
//        sut.stackView = stackView
//        sut.speciesLabel = speciesLabel
//        sut.locationLabel = locationLabel
//    }
//
//    override func tearDown() {
//        super.tearDown()
//
//        sut = nil
//        characterImage = nil
//        nameLabel = nil
//        manager = nil
//        stackView = nil
//        speciesLabel = nil
//        locationLabel = nil
//    }
//
//    func test_whenDisplay_thenCellDisplayed() {
//        let char = Character.mock
//
//        sut.display(with: char)
//
//        XCTAssertEqual(nameLabel.text, "")
//        XCTAssertEqual(locationLabel.text, "")
//    }
//}
