//
//  AppDelegate.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    var products: [Product] {
//        let productCount = 20
//        var collection: [Product] = []
//        for index in 0...productCount {
//            collection.append(Product(title: "Product\(index) "))
//        }
//        return collection
//    }
    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLandingWindow()

        return true
    }
    
    private func setupLandingWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
//        let viewModel = ProductsViewModel(products: self.products)
//        let viewModel = ProductsViewModel()
        let viewController = MainTabBarController()
                
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
    



}

