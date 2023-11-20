//
//  Router.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//

class Router {
    // MARK: - Properties
    weak var viewController: ViewController?

    // MARK: - Init
    required init(viewController: ViewController?) {
        self.viewController = viewController
    }
}
