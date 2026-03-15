import XCTest
import RealmSwift
@testable import Shopping_App

final class CartViewModelTests: XCTestCase {

    private var sut: CartViewModel!

    override func setUp() {
        super.setUp()
        sut = CartViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Helpers

    private func makeOrder(id: String = UUID().uuidString,
                           label: String = "Product",
                           amount: Int = 1,
                           price: Double = 10.0) -> OrderEntity {
        let order = OrderEntity()
        order._id = id
        order.productLabel = label
        order.amount = amount
        order.price = price
        return order
    }

    // MARK: - getCartTotal

    func test_getCartTotal_emptyCart() {
        sut.orders = []

        let total = sut.getCartTotal()

        XCTAssertEqual(total, 0.0, accuracy: 0.001)
    }

    func test_getCartTotal_singleOrder() {
        sut.orders = [makeOrder(amount: 2, price: 15.50)]

        let total = sut.getCartTotal()

        XCTAssertEqual(total, 31.0, accuracy: 0.001)
    }

    func test_getCartTotal_multipleOrders() {
        sut.orders = [
            makeOrder(id: "1", amount: 2, price: 10.0),
            makeOrder(id: "2", amount: 3, price: 5.0),
            makeOrder(id: "3", amount: 1, price: 20.0)
        ]

        let total = sut.getCartTotal()

        // (2 * 10) + (3 * 5) + (1 * 20) = 20 + 15 + 20 = 55
        XCTAssertEqual(total, 55.0, accuracy: 0.001)
    }

    func test_getCartTotal_zeroQuantity() {
        sut.orders = [makeOrder(amount: 0, price: 99.99)]

        let total = sut.getCartTotal()

        XCTAssertEqual(total, 0.0, accuracy: 0.001)
    }

    func test_getCartTotal_fractionalPrices() {
        sut.orders = [
            makeOrder(id: "1", amount: 1, price: 9.99),
            makeOrder(id: "2", amount: 2, price: 4.49)
        ]

        let total = sut.getCartTotal()

        // (1 * 9.99) + (2 * 4.49) = 9.99 + 8.98 = 18.97
        XCTAssertEqual(total, 18.97, accuracy: 0.001)
    }

    // MARK: - Realm Integration

    func test_orders_loadsFromRealm() {
        let realm = InMemoryRealmHelper.makeRealm()
        // swiftlint:disable:next force_try
        try! realm.write {
            let order1 = OrderEntity()
            order1._id = "r1"
            order1.productLabel = "Widget"
            order1.amount = 2
            order1.price = 15.0
            realm.add(order1)

            let order2 = OrderEntity()
            order2._id = "r2"
            order2.productLabel = "Gadget"
            order2.amount = 1
            order2.price = 25.0
            realm.add(order2)
        }

        let viewModel = CartViewModel()
        viewModel.injectedRealm = realm

        // Trigger the lazy var by accessing orders
        let orders = viewModel.orders

        XCTAssertEqual(orders.count, 2)
    }

    func test_getCartTotal_fromRealmOrders() {
        let realm = InMemoryRealmHelper.makeRealm()
        // swiftlint:disable:next force_try
        try! realm.write {
            let order1 = OrderEntity()
            order1._id = "r1"
            order1.productLabel = "Widget"
            order1.amount = 3
            order1.price = 10.0
            realm.add(order1)

            let order2 = OrderEntity()
            order2._id = "r2"
            order2.productLabel = "Gadget"
            order2.amount = 2
            order2.price = 7.50
            realm.add(order2)
        }

        let viewModel = CartViewModel()
        viewModel.injectedRealm = realm

        let total = viewModel.getCartTotal()

        // (3 * 10) + (2 * 7.50) = 30 + 15 = 45
        XCTAssertEqual(total, 45.0, accuracy: 0.001)
    }
}
