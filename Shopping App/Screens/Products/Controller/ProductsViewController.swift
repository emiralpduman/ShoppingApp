//
//  ProductsViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit

final class ProductsViewController: UIViewController {
    private let viewModel: ProductsViewModel
    
    // MARK: - Properties
    private lazy var mainView = ProductsView()
    
    // MARK: - Initilization
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
    }
}

//ProductsCollectionView delegate conformance
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as? ProductsCollectionViewCell else {
            fatalError("ProductsCollectionViewCell was not found")
        }
        
        viewCell.product = viewModel.products[indexPath.row]
        return viewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = ProductDetailViewController(product: viewModel.products[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}
