//
//  ProductDetailViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 1.11.2022.
//

import UIKit
import FirebaseAuth

final class ProductDetailViewController: UIViewController, RealmReachable {
    
    // MARK: - Properties
    private var mainView = ProductDetailView()
    

    
    // MARK: - Initialization
    init(product: ProductEntity) {
        guard let rating = product.rating else {
            fatalError("Product rating could not be retreived.")
        }
        mainView.productImageView.kf.setImage(with: URL(string: product.image))
        mainView.productNameLabel.text = product.title
        mainView.productPriceLabel.text = "\(product.price)"
        mainView.productDescriptionLabel.text = product.description
        mainView.productCategoryLabel.text = "Category: \(product.category)"
        mainView.productRatingRateLabel.text = "Rating: \(rating.rate)"
        mainView.productRatingCountLabel.text = "Rated by: \(rating.count) Users"
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
    func didTapAddToCart(quantity: Int) {
        if quantity == 0 {
            return
        } else {
            let order = OrderEntity()
            order.amount = quantity
            order.productLabel = mainView.productNameLabel.text!
            order.price = Double( mainView.productPriceLabel.text!)!
            order._id = UUID().uuidString
            
            let user = Auth.auth().currentUser
            let userKey = user?.uid
            
            let userInDb = realm.object(ofType: UserEntity.self, forPrimaryKey: userKey)
            
            try! realm.write {
                userInDb!.cart.append(order)
            }
            
            self.presentedViewController?.dismiss(animated: true)
        }
    }
    
    func didSwipeDown() {
        self.presentedViewController?.dismiss(animated: true)
    }
}


