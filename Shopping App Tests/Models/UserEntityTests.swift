import XCTest
import RealmSwift
@testable import Shopping_App

final class UserEntityTests: XCTestCase {

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
        let schema = UserEntity().objectSchema
        XCTAssertEqual(schema.primaryKeyProperty?.name, "_id")
    }

    func test_defaultValues() {
        let user = UserEntity()
        XCTAssertEqual(user._id, "")
        XCTAssertEqual(user.userName, "")
        XCTAssertEqual(user.emailAddress, "")
        XCTAssertEqual(user.cart.count, 0)
    }

    func test_cartRelationship_addOrders() {
        let order1 = OrderEntity()
        order1._id = "order-1"
        order1.productLabel = "Product A"
        order1.amount = 2
        order1.price = 15.0

        let order2 = OrderEntity()
        order2._id = "order-2"
        order2.productLabel = "Product B"
        order2.amount = 1
        order2.price = 25.0

        let user = UserEntity()
        user._id = "user-1"
        user.userName = "Test User"
        user.emailAddress = "test@example.com"

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(user)
            user.cart.append(order1)
            user.cart.append(order2)
        }

        let fetched = realm.object(ofType: UserEntity.self, forPrimaryKey: "user-1")
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.cart.count, 2)
        XCTAssertEqual(fetched?.cart[0].productLabel, "Product A")
        XCTAssertEqual(fetched?.cart[1].productLabel, "Product B")
    }

    func test_cartRelationship_removeOrder() {
        let order = OrderEntity()
        order._id = "order-rm"
        order.productLabel = "To Remove"
        order.amount = 1
        order.price = 10.0

        let user = UserEntity()
        user._id = "user-rm"

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(user)
            user.cart.append(order)
        }

        XCTAssertEqual(user.cart.count, 1)

        // swiftlint:disable:next force_try
        try! realm.write {
            user.cart.remove(at: 0)
        }

        let fetched = realm.object(ofType: UserEntity.self, forPrimaryKey: "user-rm")
        XCTAssertEqual(fetched?.cart.count, 0)
    }
}
