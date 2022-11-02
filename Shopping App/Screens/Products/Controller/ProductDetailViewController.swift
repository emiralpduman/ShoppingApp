//
//  ProductDetailViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 1.11.2022.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    private var mainView = ProductDetailView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Detail"
        view = mainView
        view.backgroundColor = .white
        
        mainView.delegate = self
        mainView.product = Product()
        
        
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton: UIButton) {
        <#code#>
    }
    
    func productDetailView(_ view: ProductDetailView, didTapStepper: UIStepper) {
        view.quantity = Int(didTapStepper.value)
    }

}


