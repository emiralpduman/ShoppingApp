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
        order1.productImage = "https://cdn.cimri.io/image/1000x1000/sonyplaystationoyunkonsolu_622618971.jpg"
        order1.productLabel = "PlayStation 5"
        order1.amount = 1
        
        let order2 = OrderEntity()
        order2._id = "2"
        order2.productImage = "https://st-troy.mncdn.com/mnresize/1500/1500/Content/media/ProductImg/original/mq9t3tua-apple-iphone-14-pro-max-128gb-derin-mor-mq9t3tua-637987439987787461.jpg"
        order2.productLabel = "iPhone 14 Pro Max"
        order2.amount = 2
        
        return [order1, order2]
    }()
    
}
