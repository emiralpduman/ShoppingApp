//
//  ProductDetailViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 1.11.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var mainView = ProductDetailView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Detail"
        view = mainView
        view.backgroundColor = .white
        mainView.product = Product()
    }

}
