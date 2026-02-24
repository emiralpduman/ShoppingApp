//
//  Product.swift
//  Shopping App API
//
//  Created by Emiralp Duman on 3.11.2022.
//

import Foundation

public struct Product: Decodable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

public struct Rating: Decodable {
    let rate: Double?
    let count: Int?
}
