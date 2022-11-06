//
//  ProductsViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 30.10.2022.
//

import Foundation
import ShoppingAppAPI

protocol ProductsViewModelDelegate: AnyObject {
    func didErrorOccur(_ error: Error)
    func didFetchProducts()
}

final class ProductsViewModel: RealmReachable {
    var products: [ProductEntity] = []
    weak var delegate: ProductsViewModelDelegate?
    
    init() {
        products = realm.objects(ProductEntity.self).map { $0 }
    }
    
}
