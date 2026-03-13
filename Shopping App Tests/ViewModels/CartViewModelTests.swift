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
}
