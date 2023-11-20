import Foundation
import UIKit

class Container {
    static let shared = Container()

    var window: UIWindow?
}

extension Container {
    func tabBarBuilder() -> TabBarBuilder {
        return TabBarBuilder()
    }

    func charactersBuilder() -> CharactersBuilder {
        return CharactersBuilder()
    }

    func favoritesBuilder() -> FavoritesBuilder {
        return FavoritesBuilder()
    }

    func characterDetailBuilder() -> CharacterDetailBuilder {
        return CharacterDetailBuilder()
    }
}
