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
    var products: [Product] = []
    weak var delegate: ProductsViewModelDelegate?
    
    init() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            self.products = try JSONDecoder().decode([Product].self, from: jsonData )
        }
        catch {
            fatalError("JSON data could not be received from JSON file.")
        }

        
        // This comment line will be uncommented before app is shipped.
//        fakeStoreAPI.request(.getProducts) { result in
//            switch result {
//            case .failure(let error):
//                self.delegate?.didErrorOccur(error)
//            case .success(let response):
//
//
//
//                do {
//                    self.products = try JSONDecoder().decode([Product].self, from: response.data)
//
//                    self.products.forEach { product in
//
//                        guard self.realm.object(ofType: ProductEntity.self, forPrimaryKey: product.id) == nil else {
//                            return
//                        }
//
//                        let productEntity = ProductEntity()
//                        productEntity._id = product.id ?? .zero
//                        productEntity.title = product.title!
//                        productEntity.price = product.price!
//                        productEntity.desc = product.description!
//                        productEntity.category = product.category!
//                        productEntity.image = product.image!
//
//                        let ratingEntity = RatingEntity()
//                        ratingEntity.rate = product.rating!.rate!
//                        ratingEntity.count = product.rating!.count!
//
//                        productEntity.rating = ratingEntity
//
//                        do {
//                            try self.realm.write {
//                                self.realm.add(productEntity)
//                            }
//                        } catch {
//                            self.delegate?.didErrorOccur(error)
//                        }
//                    }
//                    self.delegate?.didFetchProducts()
//                } catch {
//                    self.delegate?.didErrorOccur(error)
//                }
//            }
//        }
    }
    
}
