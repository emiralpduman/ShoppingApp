//
//  ProductDetailView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 1.11.2022.
//

import UIKit
import Kingfisher

protocol ProductDetailViewDelegate: AnyObject {
    func productDetailView(_ view: ProductDetailView, didTapStepper: UIStepper)
    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton: UIButton)

}

final class ProductDetailView: UIView {
    
    // MARK: - Properties
    weak var delegate: ProductDetailViewDelegate?
    
    var product: Product {
        didSet {
            productImageView.kf.setImage(with: URL(string: product.imageURL))
            productNameLabel.text = product.title
            productPriceLabel.text = "\(product.price) TL"
            productDescriptionLabel.text = product.description
            productCategoryLabel.text = "Category: \(product.category)"
            productRatingRateLabel.text = "Rating: \(product.rating.rate)"
            productRatingCountLabel.text = "Rated by: \(product.rating.count) Users"
        }
    }
    
    var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "Amount: \(quantity)"
        }
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    // MARK: - Visual Elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private var productDescriptionLabel = UILabel()
    private var productCategoryLabel = UILabel()
    private var productRatingRateLabel = UILabel()
    private var productRatingCountLabel = UILabel()
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productRatingRateLabel,
                                                       productRatingCountLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var productDetailsStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [productNameLabel,
                                                      productPriceLabel,
                                                      productDescriptionLabel,
                                                      productCategoryLabel,
                                                      ratingStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = stackViewSpacing
        return stackView
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        return button
    }()
    
    private lazy var quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(didTapQuantityStepper), for: .valueChanged)
        return stepper
    }()
    private lazy var quantityLabel: UILabel = {
       let label = UILabel()
        label.text = "Amount: \(quantity)"
        return label
    }()
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityLabel, quantityStepper])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = stackViewSpacing
        return stackView
    }()
    private lazy var addToCartStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [quantityStackView, addToCartButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = stackViewSpacing + CGFloat(bottomSpacing)
        return stackView
    }()
    
    override init(frame: CGRect) {
        self.product = Product()
        super.init(frame: frame)
        
        //Adding subviews
        addSubview(productImageView)
        productImageView.snp.makeConstraints() { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        addSubview(productDetailsStackView)
        productDetailsStackView.snp.makeConstraints() { make in
            make.top.equalTo(productImageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        addSubview(addToCartStackView)
        addToCartStackView.snp.makeConstraints() { make in
            make.top.equalTo(productDetailsStackView.snp.bottom).offset(offset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bottomInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapQuantityStepper(_ sender: UIStepper) {
        delegate?.productDetailView(self, didTapStepper: sender)
    }
    
    // Drawing Constants
    private let inset: CGFloat = 10
    private let offset: CGFloat = 10
    private let stackViewSpacing: CGFloat = 10
    private let bottomInset: CGFloat = 50
    private let bottomSpacing: CGFloat = 10

}
