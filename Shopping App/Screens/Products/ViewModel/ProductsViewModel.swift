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

final class ProductsViewModel {
    var products: [Product] = []
    weak var delegate: ProductsViewModelDelegate?
    
    init() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        fakeStoreAPI.request(.getProducts) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccur(error)
            case .success(let response):
                do {
                    self.products = try JSONDecoder().decode([Product].self, from: response.data)
                    self.delegate?.didFetchProducts()
                } catch {
                    self.delegate?.didErrorOccur(error)
                }
            }
        }
    }
    
}
