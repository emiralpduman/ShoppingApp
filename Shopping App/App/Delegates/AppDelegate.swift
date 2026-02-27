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

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLandingWindow()
        FirebaseApp.configure()

        UITabBar.appearance().tintColor = UIColor(named: "primary")
        UINavigationBar.appearance().tintColor = UIColor(named: "primary")

        return true
    }

    private func setupLandingWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: LaunchViewController())

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }
}
