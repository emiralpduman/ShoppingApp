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

    // MARK: - Initialization
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
        mainView.searchBar.delegate = self
        mainView.configureCategoryButtons(viewModel.categories)
        mainView.onCategorySelected = { [weak self] category in
            guard let self else { return }
            viewModel.filterProducts(searchText: viewModel.currentSearchText, category: category)
        }
    }
}

// ProductsCollectionView delegate conformance
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "productsCell",
            for: indexPath
        ) as? ProductsCollectionViewCell else {
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

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterProducts(searchText: searchText, category: viewModel.selectedCategory)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterProducts(searchText: "", category: viewModel.selectedCategory)
    }
}

extension ProductsViewController: ProductsViewModelDelegate {
    func didErrorOccur(_ error: Error) {
        print(error.localizedDescription)
    }

    func didFetchProducts() {
        mainView.productsCollectionView.reloadData()
    }
}
