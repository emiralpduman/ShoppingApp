//
//  RatingEntity.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import RealmSwift

class RatingEntity: Object {
    @Persisted var rate: Double
    @Persisted var count: Int
}
