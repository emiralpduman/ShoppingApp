//
//  ProductsViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import Foundation
import RealmSwift
import ShoppingAppAPI

protocol ProductsViewModelDelegate: AnyObject {
    func didErrorOccur(_ error: Error)
    func didFetchProducts()
}

final class ProductsViewModel: RealmReachable {
    var injectedRealm: Realm?
    weak var delegate: ProductsViewModelDelegate?

    private(set) var allProducts: [ProductEntity] = []
    private(set) var products: [ProductEntity] = []
    private(set) var categories: [String] = []

    private(set) var currentSearchText: String = ""
    private(set) var selectedCategory: String? = nil

    init(realm: Realm? = nil) {
        self.injectedRealm = realm
        allProducts = self.realm.objects(ProductEntity.self).map { $0 }
        products = allProducts
        categories = ["All"] + Array(Set(allProducts.map { $0.category })).sorted()
    }

    func filterProducts(searchText: String, category: String?) {
        currentSearchText = searchText
        selectedCategory = category
        products = allProducts.filter { product in
            let matchesSearch = searchText.isEmpty ||
                product.title.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = category == nil || category == "All" ||
                product.category == category
            return matchesSearch && matchesCategory
        }
        delegate?.didFetchProducts()
    }
}
