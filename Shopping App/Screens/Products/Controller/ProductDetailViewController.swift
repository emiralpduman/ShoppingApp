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
    

    
    // MARK: - Initialization
    init(product: Product) {
        mainView.productImageView.kf.setImage(with: URL(string: product.imageURL))
        mainView.productNameLabel.text = product.title
        mainView.productPriceLabel.text = "\(product.price) TL"
        mainView.productDescriptionLabel.text = product.description
        mainView.productCategoryLabel.text = "Category: \(product.category)"
        mainView.productRatingRateLabel.text = "Rating: \(product.rating.rate)"
        mainView.productRatingCountLabel.text = "Rated by: \(product.rating.count) Users"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Detail"
        view = mainView
        view.backgroundColor = .white
        
        mainView.delegate = self
    }
    
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton: UIButton) {
        let controller = AddToCartViewController()
        controller.presentationDelegate = self
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        present(controller, animated: true)

    }
}

extension ProductDetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
        return presentationController
    }
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        let presentationHeight: CGFloat = 150
        return CGRect(x: 0, y: bounds.height-presentationHeight, width: bounds.width, height: presentationHeight)
    }
}

extension ProductDetailViewController: PresentationDelegate {
    func didSwipeDown() {
        self.presentedViewController?.dismiss(animated: true)
    }
}


