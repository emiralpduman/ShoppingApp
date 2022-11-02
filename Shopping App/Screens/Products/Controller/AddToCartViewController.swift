//
//  AddToCartViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 2.11.2022.
//

import UIKit

final class AddToCartViewController: UIViewController {
    
    // MARK: - Properties
    private var mainView = AddToCartView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add to Cart"
        view = mainView
        view.backgroundColor = .white

        
        mainView.delegate = self
    }

}

extension AddToCartViewController: AddToCartViewDelegate {
    func addToCartView(_ view: AddToCartView, didTapStepper: UIStepper) {
        view.quantity = Int(didTapStepper.value)
    }
    
    
}





