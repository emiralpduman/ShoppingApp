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
        
        var productsNavigationViewControler: UINavigationController = {
            let navCont = UINavigationController(rootViewController: ProductsViewController(viewModel: ProductsViewModel()))
            navCont.tabBarItem = UITabBarItem(title: navCont.title, image: UIImage(), tag: 0)
            return navCont
        }()
        let searchNavigationViewController = UINavigationController(rootViewController: UIViewController())
        let profileNavigationViewController = UIViewController()
        
        setViewControllers([productsNavigationViewControler, searchNavigationViewController, profileNavigationViewController], animated: true)
        selectedIndex = 0
    }
    


}
