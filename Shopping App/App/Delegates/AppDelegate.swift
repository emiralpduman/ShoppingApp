//
//  AppDelegate.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit
import SnapKit
import FirebaseCore
import RealmSwift

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
        FirebaseApp.configure()
        
        UITabBar.appearance().tintColor = UIColor(named: "primary")
        UINavigationBar.appearance().tintColor = UIColor(named: "primary")
    

        return true
    }
    
    private func setupLandingWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)

//        let viewController = MainTabBarController()
//        let viewController = AuthViewController()
        let navigationController = UINavigationController(rootViewController: LaunchViewController())
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    



}

