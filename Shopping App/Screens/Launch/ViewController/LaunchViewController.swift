//
//  LaunchViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: - Properties
    private let mainView: UIView = LaunchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
        view = mainView
        view.backgroundColor = mainColor

    }

    // MARK: - Visual Constants
    private let mainColor: UIColor = .red
}
