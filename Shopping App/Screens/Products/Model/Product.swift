//
//  Product.swift
//  Shopping App
//
//  Created by Emiralp Duman on 31.10.2022.
//

import Foundation

struct Product: Codable {
    var id: Int = 0
    var title: String = "Product's name"
    var price: Double = 99.99
    var description: String = "Product's description"
    var category: String = "Product's category"
    var imageURL: String = "https://cdn.cimri.io/image/1000x1000/sonyplaystationoyunkonsolu_622618971.jpg"
    var rating: Rating = Rating()
}

struct Rating: Codable {
    var rate: Double = 9.9
    var count: Int = 99
}

