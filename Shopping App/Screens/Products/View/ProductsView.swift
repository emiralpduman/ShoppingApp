//
//  ProductsView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit

final class ProductsView: UIView {
    
    // MARK: - Properties
    private var cellWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var cellHeight: CGFloat {
        cellWidth * 0.5
    }


    // MARK: - Subviews
    
    // CollectionView
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return flowlayout
    }()
    private lazy var productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: - Init
    
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
    
    //Sets delegates for productsCollectiponView
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate,
                                   andDataSource dataSource: UICollectionViewDataSource) {
        productsCollectionView.delegate = delegate
        productsCollectionView.dataSource = dataSource
    }
    
}
