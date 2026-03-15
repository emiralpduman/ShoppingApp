//
//  ProfileViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import Foundation
import RealmSwift

class ProfileViewModel: RealmReachable {
    var injectedRealm: Realm?
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthService()) {
        self.authService = authService
    }

    lazy var user: UserEntity = {
        let userKey = authService.currentUserUid

        guard let userInDb = self.realm.object(ofType: UserEntity.self, forPrimaryKey: userKey) else {
            fatalError("User not found in database")
        }
        return userInDb
    }()

    lazy var cartTotal: Double = {
        let orders = user.cart
        var sumOfOrders: Double = 0

        for order in orders {
            sumOfOrders += Double(order.amount) * order.price
        }

        return sumOfOrders
    }()
}
