//
//  FavoritesBuilder.swift
//  RickAndMorty
//
//  Created by axel on 9/8/23.
//  
//

import UIKit

final class FavoritesBuilder {

	func build() -> FavoritesViewController {

        let viewController = FavoritesViewController()

        let useCase = CharacterUseCase()
        let router = FavoritesRouter(viewController: viewController)
        let viewModel = FavoritesViewModel(router: router, useCase: useCase)

		viewController.viewModel = viewModel

		return viewController
	}
}
