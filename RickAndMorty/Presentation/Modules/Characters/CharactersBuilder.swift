//
//  CharactersBuilder.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//  
//

import UIKit

final class CharactersBuilder {

	func build() -> CharactersViewController {

        let viewController = CharactersViewController()

        let useCase = CharacterUseCase()
        let router = CharactersRouter(viewController: viewController)

        let viewModel = CharactersViewModel(router: router, useCase: useCase)

		viewController.viewModel = viewModel

		return viewController
	}
}
