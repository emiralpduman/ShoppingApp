import XCTest
import RealmSwift
@testable import Shopping_App

final class RatingEntityTests: XCTestCase {

    private var realm: Realm!

    override func setUp() {
        super.setUp()
        realm = InMemoryRealmHelper.makeRealm()
    }

    override func tearDown() {
        realm = nil
        super.tearDown()
    }

    func test_defaultValues() {
        let rating = RatingEntity()
        XCTAssertEqual(rating.rate, 0.0)
        XCTAssertEqual(rating.count, 0)
    }

    func test_persistAndFetch() {
        let rating = RatingEntity()
        rating.rate = 3.9
        rating.count = 120

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(rating)
        }

        let fetched = realm.objects(RatingEntity.self).first
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.rate, 3.9)
        XCTAssertEqual(fetched?.count, 120)
    }
}
