//
//  CharacterDetailBuilder.swift
//  RickAndMorty
//
//  Created by axel on 3/8/23.
//  
//

import UIKit

final class CharacterDetailBuilder {

    func build(character: Character, didExitView: @escaping ((Character) -> Void)) -> CharacterDetailViewController {

        let viewController = CharacterDetailViewController()

        let useCase = CharacterUseCase()
        let router = CharacterDetailRouter(viewController: viewController)
        let imageUseCase = ImageUseCase()
        let viewModel = CharacterDetailViewModel(router: router,
                                                 useCase: useCase,
                                                 imageUseCase: imageUseCase,
                                                 character: character,
                                                 didExitView: didExitView)

        viewController.viewModel = viewModel

        return viewController
    }
}
