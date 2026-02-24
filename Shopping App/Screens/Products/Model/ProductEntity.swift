//
//  ProductEntity.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import RealmSwift

class ProductEntity: Object {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var title: String
    @Persisted var price: Double
    @Persisted var desc: String
    @Persisted var category: String
    @Persisted var image: String
    @Persisted var rating: RatingEntity?
}
