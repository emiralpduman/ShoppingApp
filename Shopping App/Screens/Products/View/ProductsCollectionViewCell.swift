//
//  ProductsCollectionViewCell.swift
//  Shopping App
//
//  Created by Emiralp Duman on 31.10.2022.
//

import UIKit
import Kingfisher

final class ProductsCollectionViewCell: UICollectionViewCell {
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 50
    let labelHorizontalInsetWRTImage: CGFloat = 40
    let labelVerticalInsetWRTImage: CGFloat = 10
    
    //MARK: - Properties
    var product: Product? {
        didSet {
            guard let product = product, let image = product.image, let price = product.price else {
                fatalError("Product information could not be received.")
            }
            productImageView.kf.setImage(with: URL(string: image ))
            productNameLabel.text = product.title
            productPriceLabel.text = String(price)
        }
    }
    
    //MARK: - Visual Elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = cornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var productNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        return nameLabel
    }()
    private lazy var productPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .white
        return priceLabel
    }()
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Adding subviews
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(labelHorizontalInsetWRTImage/3)
            make.trailing.equalToSuperview().inset(labelHorizontalInsetWRTImage/3)
            make.bottom.equalToSuperview()
        }
        
        addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.leading).inset(labelHorizontalInsetWRTImage)
            make.bottom.equalTo(productImageView.snp.bottom).inset(labelVerticalInsetWRTImage)
        }
        
        addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productNameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(labelHorizontalInsetWRTImage)
            make.top.equalTo(productNameLabel.snp.top)
            make.bottom.equalTo(productNameLabel.snp.bottom)
        }
        
         productImageView.layer.insertSublayer(gradientLayer, at: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}


