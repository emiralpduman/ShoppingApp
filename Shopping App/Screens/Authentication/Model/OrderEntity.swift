//
//  OrderEntity.swift
//  Shopping App
//
//  Created by Emiralp Duman on 5.11.2022.
//

import Foundation
import RealmSwift

class OrderEntity: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var productLabel: String
    @Persisted var amount: Int
    @Persisted var price: Double
}
