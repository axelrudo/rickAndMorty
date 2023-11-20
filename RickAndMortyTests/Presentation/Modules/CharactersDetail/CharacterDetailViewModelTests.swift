//
//  CharacterDetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by axel on 7/8/23.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {

    var router: CharacterDetailRouterFake!
    var useCase: CharactersUseCaseFake!
    var imageUseCase: ImageUseCaseFake!
    var didExitView: ((Character) -> Void)!
    var character: Character!
    var sut: CharacterDetailViewModel!

    private func customSetup() {
        router = CharacterDetailRouterFake()
        useCase = CharactersUseCaseFake()
        character = Character.mock
        imageUseCase = ImageUseCaseFake()
        didExitView = { _ in }
        sut = CharacterDetailViewModel(router: router,
                                       useCase: useCase,
                                       imageUseCase: imageUseCase,
                                       character: character,
                                       didExitView: didExitView)
    }

    private func customTearDown() {
        router = nil
        useCase = nil
        sut = nil
        character = nil
        imageUseCase = nil
        didExitView = nil
    }


    

}
