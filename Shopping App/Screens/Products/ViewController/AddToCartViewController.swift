//
//  AddToCartViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 2.11.2022.
//

import UIKit

protocol PresentationDelegate: AnyObject {
    func didSwipeDown()
    func didTapAddToCart(quantity: Int)
}

final class AddToCartViewController: UIViewController {

    // MARK: - Properties
    private var mainView = AddToCartView()
    weak var presentationDelegate: PresentationDelegate?

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
        presentationDelegate?.didSwipeDown()
    }

    func addToCartView(_ view: AddToCartView, didTapQuantityStepper: UIStepper) {
        view.quantity = Int(didTapQuantityStepper.value)
    }

    func addToCartView(_ view: AddToCartView, didTapAddButton: UIButton) {
        presentationDelegate?.didTapAddToCart(quantity: mainView.quantity)
    }
}
