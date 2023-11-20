//
//  CharactersRouter.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//  
//

import UIKit

protocol CharactersRouterProtocol {
    func characterDetail(of character: Character)
}

final class CharactersRouter: Router {
 
}

extension CharactersRouter: CharactersRouterProtocol {
    func characterDetail(of character: Character) {
        let charactersVC = Container.shared.characterDetailBuilder().build(character: character) { character in
            self.characterDetail(of: character)
        }
        self.viewController?.present(charactersVC, animated: true)
    }
}
