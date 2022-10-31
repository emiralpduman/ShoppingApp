//
//  ProductsView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit

final class ProductsView: UIView {
    
    //MARK: -Properties
    
    var products: [Product]?
    
    //MARK: - Subviews
    
    private lazy var productsCollectionView = UICollectionView()
    
    //MARK: -Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        setupProductsCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    //Subview Building Methods
    private func setupProductsCollectionView() {
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "productsCell")
        addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
