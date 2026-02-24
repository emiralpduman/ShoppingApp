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
        
//        let productsNavigationViewControler: UINavigationController = {
//            let navCont = UINavigationController(rootViewController: ProductsViewController(viewModel: ProductsViewModel()))
//            navCont.tabBarItem = UITabBarItem(title: navCont.title, image: UIImage(), tag: 0)
//            return navCont
//        }()
//        let searchNavigationViewController = UINavigationController(rootViewController: UIViewController())
//        let profileNavigationViewController = UIViewController()
//
//        setViewControllers([productsNavigationViewControler, searchNavigationViewController, profileNavigationViewController], animated: true)
        
        let products = ProductsViewController(viewModel: ProductsViewModel())
        products.tabBarItem = UITabBarItem(title: products.title, image: UIImage(named: "products"), tag: 0)
        
        let search = UINavigationController(rootViewController: UIViewController())
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        
        let profile = UINavigationController(rootViewController: UIViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)
        setViewControllers([products, search, profile], animated: true)
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(didTapCart))
        selectedIndex = 0
        
        
        
        
    }
    
    @objc func didTapCart() {
        navigationController?.pushViewController(CartViewController(), animated: true)
    }
    


}
