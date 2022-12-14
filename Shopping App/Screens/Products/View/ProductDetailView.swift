//
//  ProductDetailView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 1.11.2022.
//

import UIKit
import Kingfisher

protocol ProductDetailViewDelegate: AnyObject {
    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton: UIButton)
}

final class ProductDetailView: UIView {
    
    // MARK: - Properties
    weak var delegate: ProductDetailViewDelegate?
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    // MARK: - Visual Elements
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    var productDescriptionLabel = UILabel()
    var productCategoryLabel = UILabel()
    var productRatingRateLabel = UILabel()
    var productRatingCountLabel = UILabel()
    
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
        button.addTarget(self, action: #selector(didTapAddToCartButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "primary")
        button.tintColor = .white
        return button
    }()
    

//    private lazy var addToCartStackView: UIStackView = {
//       let stackView = UIStackView(arrangedSubviews: [quantityStackView, addToCartButton])
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.alignment = .center
//        stackView.spacing = stackViewSpacing + CGFloat(bottomSpacing)
//        return stackView
//    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
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
        addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints() { make in
            make.top.equalTo(productDetailsStackView.snp.bottom).offset(offset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bottomInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate Methods
    
    @objc private func didTapAddToCartButton(_ sender: UIButton) {
        delegate?.productDetailView(self, didTapAddToCartButton: sender)
    }
    
    // Drawing Constants
    private let inset: CGFloat = 10
    private let offset: CGFloat = 10
    private let stackViewSpacing: CGFloat = 10
    private let bottomInset: CGFloat = 50
    private let bottomSpacing: CGFloat = 10

}
