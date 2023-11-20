//
//  FavoritesRouter.swift
//  RickAndMorty
//
//  Created by axel on 9/8/23.
//  
//

import UIKit

protocol FavoritesRouterProtocol {
    func characterDetail(of character: Character)
}

final class FavoritesRouter: Router {

}

extension FavoritesRouter: FavoritesRouterProtocol {
    func characterDetail(of character: Character) {
        let charactersVC = Container.shared.characterDetailBuilder().build(character: character) { character in
            self.characterDetail(of: character)
        }
        self.viewController?.present(charactersVC, animated: true)
    }
}
