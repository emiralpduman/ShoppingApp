import XCTest
import RealmSwift
@testable import Shopping_App

final class OrderEntityTests: XCTestCase {

    private var realm: Realm!

    override func setUp() {
        super.setUp()
        realm = InMemoryRealmHelper.makeRealm()
    }

    override func tearDown() {
        realm = nil
        super.tearDown()
    }

    func test_primaryKey() {
        let schema = OrderEntity().objectSchema
        XCTAssertEqual(schema.primaryKeyProperty?.name, "_id")
    }

    func test_defaultValues() {
        let order = OrderEntity()
        XCTAssertEqual(order._id, "")
        XCTAssertEqual(order.productLabel, "")
        XCTAssertEqual(order.amount, 0)
        XCTAssertEqual(order.price, 0.0)
    }

    func test_persistAndFetch() {
        let order = OrderEntity()
        order._id = "test-order-1"
        order.productLabel = "Test Product"
        order.amount = 3
        order.price = 29.99

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(order)
        }

        let fetched = realm.object(ofType: OrderEntity.self, forPrimaryKey: "test-order-1")
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.productLabel, "Test Product")
        XCTAssertEqual(fetched?.amount, 3)
        XCTAssertEqual(fetched?.price, 29.99)
    }
}
