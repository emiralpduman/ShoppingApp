//
//  UserEntity.swift
//  Shopping App
//
//  Created by Emiralp Duman on 5.11.2022.
//

import Foundation
import RealmSwift

class UserEntity: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var userName: String
    @Persisted var emailAddress: String
    @Persisted var cart: List<OrderEntity>
}

class OrderEntity: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var productImage: String
    @Persisted var productLabel: String
    @Persisted var amount: Int
}
