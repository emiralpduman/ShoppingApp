//
//  CartViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import Foundation

class CartViewModel {
    lazy var orders: [OrderEntity] = {
        let order1 = OrderEntity()
        order1._id = "1"
        order1.productLabel = "PlayStation 5"
        order1.amount = 1
        order1.price = 100
        
        let order2 = OrderEntity()
        order2._id = "2"
        order2.productLabel = "iPhone 14 Pro Max"
        order2.amount = 2
        order2.price = 200
        
        return [order1, order2]
    }()
    
    func getCartTotal() -> Double {
        var sumOfOrders: Double = 0
        
        for order in orders {
            sumOfOrders += Double(order.amount) * order.price
        }
        
        return sumOfOrders
    }
    
}
