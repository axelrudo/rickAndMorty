import UIKit

final class TabBarBuilder {

    func build() -> TabBarController {
        let tabBarVC = TabBarController()
  
        let charactersVC = Container.shared.charactersBuilder().build()
        let charactersNav = UINavigationController(rootViewController: charactersVC)

        let favoritesVC = Container.shared.favoritesBuilder().build()
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)

        tabBarVC.setViewControllers([charactersNav, favoritesNav], animated: true)
        tabBarVC.tabBar.items?[0].image = UIImage(systemName: "person.fill")
        tabBarVC.tabBar.items?[0].title = "characters_title".localized
        tabBarVC.tabBar.items?[1].image = UIImage(systemName: "person")
        tabBarVC.tabBar.items?[1].title = "favorites_title".localized

        return tabBarVC
    }
}
