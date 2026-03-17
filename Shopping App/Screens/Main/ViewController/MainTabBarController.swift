//
//  MainTabBarController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 5.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let products = ProductsViewController(viewModel: ProductsViewModel())
        products.tabBarItem = UITabBarItem(title: products.title, image: UIImage(named: "products"), tag: 0)
        products.tabBarItem.accessibilityIdentifier = "tabBar.products"

        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)
        profile.tabBarItem.accessibilityIdentifier = "tabBar.profile"
        setViewControllers([products, profile], animated: true)

        navigationItem.hidesBackButton = true
        let cartBarButton = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(didTapCart))
        cartBarButton.accessibilityIdentifier = "navBar.cartButton"
        navigationItem.rightBarButtonItem = cartBarButton
        selectedIndex = 0
    }

    @objc func didTapCart() {
        navigationController?.pushViewController(CartViewController(), animated: true)
    }
}
