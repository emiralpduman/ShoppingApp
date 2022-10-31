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
    let labelVerticalInsetWRTImage: CGFloat = 5
    
    //MARK: - Properties
    var product: Product {
        didSet {
            productImageView.kf.setImage(with: product.imageURL)
            productNameLabel.text = product.name
            productPriceLabel.text = String(product.price)
        }
    }
    
    //MARK: - Visual Elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var productNameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    private lazy var productPriceLabel: UILabel = {
        let priceLabel = UILabel()
        return priceLabel
    }()
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    private lazy var gradientView = UIView()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        self.product = Product()

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
        
        addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        layer.locations = [0.0, 1.0]
        gradientView.layer.addSublayer(layer)
    }
    
    
}


