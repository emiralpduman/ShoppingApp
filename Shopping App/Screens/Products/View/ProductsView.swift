//
//  ProductsView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import UIKit
import SnapKit

final class ProductsView: UIView {

    // MARK: - Properties
    private var cellWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    private var cellHeight: CGFloat {
        cellWidth * 0.5
    }

    var onCategorySelected: ((String?) -> Void)?

    private var categoryButtons: [UIButton] = []

    // MARK: - Subviews

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search products..."
        bar.searchBarStyle = .minimal
        bar.accessibilityIdentifier = "products.searchBar"
        return bar
    }()

    private lazy var categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.accessibilityIdentifier = "products.categoryScrollView"
        return scrollView
    }()

    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    // CollectionView
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return flowlayout
    }()

    lazy var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.accessibilityIdentifier = "products.collectionView"
        return collectionView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        setupCategoryScrollView()
        setupProductsCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.searchBarHeight)
        }
    }

    private func setupCategoryScrollView() {
        addSubview(categoryScrollView)
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.categoryScrollViewHeight)
        }

        categoryScrollView.addSubview(categoryStackView)
        categoryStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.height.equalToSuperview()
        }
    }

    private func setupProductsCollectionView() {
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "productsCell")
        addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryScrollView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    func configureCategoryButtons(_ categories: [String]) {
        categoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        categoryButtons = []

        for (index, category) in categories.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.tag = index
            button.layer.cornerRadius = Constants.chipCornerRadius
            button.layer.borderWidth = 1
            button.contentEdgeInsets = Constants.chipInsets
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            button.accessibilityIdentifier = "products.category.\(category)"
            styleChip(button, selected: index == 0)
            categoryStackView.addArrangedSubview(button)
            categoryButtons.append(button)
        }
    }

    @objc private func categoryButtonTapped(_ sender: UIButton) {
        categoryButtons.forEach { styleChip($0, selected: false) }
        styleChip(sender, selected: true)
        let title = sender.title(for: .normal)
        onCategorySelected?(title)
    }

    private func styleChip(_ button: UIButton, selected: Bool) {
        if selected {
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    // Sets delegates for productsCollectionView
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate,
                                   andDataSource dataSource: UICollectionViewDataSource) {
        productsCollectionView.delegate = delegate
        productsCollectionView.dataSource = dataSource
    }

    // MARK: - Constants

    private enum Constants {
        static let searchBarHeight: CGFloat = 56
        static let categoryScrollViewHeight: CGFloat = 44
        static let chipCornerRadius: CGFloat = 16
        static let chipInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
    }
}
