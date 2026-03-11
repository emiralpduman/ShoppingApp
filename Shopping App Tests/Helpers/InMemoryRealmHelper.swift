import Foundation
import RealmSwift

enum InMemoryRealmHelper {
    static func makeRealm() -> Realm {
        let config = Realm.Configuration(inMemoryIdentifier: UUID().uuidString)
        // swiftlint:disable:next force_try
        return try! Realm(configuration: config)
    }
}
