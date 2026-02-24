//
//  ProfileViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: RealmReachable {
    lazy var user: UserEntity = {
       let user = UserEntity()
        
        let authUser = Auth.auth().currentUser
        let userKey = authUser?.uid
        
        let userInDb = self.realm.object(ofType: UserEntity.self, forPrimaryKey: userKey)
        return userInDb!
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
