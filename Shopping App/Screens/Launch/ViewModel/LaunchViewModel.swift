//
//  LaunchViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import Foundation
import Moya
import RealmSwift
import ShoppingAppAPI

protocol LaunchViewModelDelegate: AnyObject {
    func didErrorOccur(_ error: Error)
    func didFetchProducts()
    func willFetchProducts()
}

class LaunchViewModel: RealmReachable {
    // MARK: - Properties
    var injectedRealm: Realm?
    weak var delegate: LaunchViewModelDelegate?
    private var products: [Product] = []
    private let provider: MoyaProvider<FakeStoreService>

    init(provider: MoyaProvider<FakeStoreService> = fakeStoreAPI) {
        self.provider = provider
    }

    // MARK: - Methods
    func fetchProducts() {
        delegate?.willFetchProducts()

        provider.request(.getProducts) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccur(error)
            case .success(let response):
                do {
                    self.products = try JSONDecoder().decode([Product].self, from: response.data)

                    self.products.forEach { product in

                        guard self.realm.object(ofType: ProductEntity.self, forPrimaryKey: product.id) == nil else {
                            return
                        }

                        let productEntity = ProductEntity()
                        productEntity._id = product.id ?? .zero
                        productEntity.title = product.title ?? ""
                        productEntity.price = product.price ?? 0
                        productEntity.desc = product.description ?? ""
                        productEntity.category = product.category ?? ""
                        productEntity.image = product.image ?? ""

                        let ratingEntity = RatingEntity()
                        ratingEntity.rate = product.rating?.rate ?? 0
                        ratingEntity.count = product.rating?.count ?? 0

                        productEntity.rating = ratingEntity

                        do {
                            try self.realm.write {
                                self.realm.add(productEntity)
                            }
                        } catch {
                            self.delegate?.didErrorOccur(error)
                        }
                    }
                    self.delegate?.didFetchProducts()
                } catch {
                    self.delegate?.didErrorOccur(error)
                }
            }
        }
    }
}
