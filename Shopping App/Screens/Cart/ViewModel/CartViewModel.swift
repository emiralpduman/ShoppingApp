//
//  CartViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import Foundation

class CartViewModel: RealmReachable {
    lazy var orders: [OrderEntity] = {
        let orders = realm.objects(OrderEntity.self)
        return Array(orders)
    }()
    
    func getCartTotal() -> Double {
        var sumOfOrders: Double = 0
        
        for order in orders {
            sumOfOrders += Double(order.amount) * order.price
        }
        
        return sumOfOrders
    }
    
}
