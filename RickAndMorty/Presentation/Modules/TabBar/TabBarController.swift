//
//  TabBarController.swift
//  RudoApp
//
//  Created by Polina on 13/10/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        let tabBarItemAppearance = UITabBarItemAppearance()
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.tintColor = .black
    }
}
