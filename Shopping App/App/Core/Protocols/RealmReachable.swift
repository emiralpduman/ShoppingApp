//
//  RealmReachable.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import RealmSwift

protocol RealmReachable { }

extension RealmReachable {
    var realm: Realm {
        let config = Realm.Configuration(
          schemaVersion: 0,
          deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config

        do {
            return try Realm()
        } catch {
            fatalError("Could not initialize Realm: \(error.localizedDescription)")
        }
    }
}
