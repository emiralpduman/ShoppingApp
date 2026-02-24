//
//  AddToCartViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 2.11.2022.
//

import UIKit

protocol PresentationDelegate {
    func didSwipeDown()
}

final class AddToCartViewController: UIViewController {
    
    // MARK: - Properties
    private var mainView = AddToCartView()
    var presentationDelegate: PresentationDelegate?

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
    func didSwipeDown() {
        if let delegate = presentationDelegate {
            delegate.didSwipeDown()
        }
    }
    
    func addToCartView(_ view: AddToCartView, didTapQuantityStepper: UIStepper) {
        view.quantity = Int(didTapQuantityStepper.value)
    }
    
    func addToCartView(_ view: AddToCartView, didTapAddButton: UIButton) {
        print("Added to cart")
    }
    
    
}





