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
    var products: [ProductEntity] = []
    weak var delegate: ProductsViewModelDelegate?

    init(realm: Realm? = nil) {
        self.injectedRealm = realm
        products = self.realm.objects(ProductEntity.self).map { $0 }
    }
}
