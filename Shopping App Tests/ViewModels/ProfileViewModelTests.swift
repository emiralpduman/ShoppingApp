import XCTest
import RealmSwift
@testable import Shopping_App

final class ProfileViewModelTests: XCTestCase {

    private var mockAuth: MockAuthService!
    private var testRealm: Realm!

    override func setUp() {
        super.setUp()
        mockAuth = MockAuthService()
        testRealm = InMemoryRealmHelper.makeRealm()
    }

    override func tearDown() {
        mockAuth = nil
        testRealm = nil
        super.tearDown()
    }

    // MARK: - Helpers

    private func makeSUT() -> ProfileViewModel {
        let viewModel = ProfileViewModel(authService: mockAuth)
        viewModel.injectedRealm = testRealm
        return viewModel
    }

    private func addUser(id: String, name: String = "Test User", email: String = "test@test.com") {
        let user = UserEntity()
        user._id = id
        user.userName = name
        user.emailAddress = email
        // swiftlint:disable:next force_try
        try! testRealm.write {
            testRealm.add(user)
        }
    }

    private func addUserWithOrders(
        id: String,
        orders: [(label: String, amount: Int, price: Double)]
    ) {
        let user = UserEntity()
        user._id = id
        user.userName = "Test User"
        user.emailAddress = "test@test.com"

        // swiftlint:disable:next force_try
        try! testRealm.write {
            for order in orders {
                let orderEntity = OrderEntity()
                orderEntity._id = UUID().uuidString
                orderEntity.productLabel = order.label
                orderEntity.amount = order.amount
                orderEntity.price = order.price
                testRealm.add(orderEntity)
                user.cart.append(orderEntity)
            }
            testRealm.add(user)
        }
    }

    // MARK: - user

    func test_user_returnsUserFromRealm() {
        let uid = "user-123"
        mockAuth.currentUserUid = uid
        addUser(id: uid, name: "Alice", email: "alice@example.com")

        let sut = makeSUT()

        XCTAssertEqual(sut.user._id, uid)
        XCTAssertEqual(sut.user.userName, "Alice")
        XCTAssertEqual(sut.user.emailAddress, "alice@example.com")
    }

    // MARK: - cartTotal

    func test_cartTotal_emptyCart_returnsZero() {
        let uid = "user-empty-cart"
        mockAuth.currentUserUid = uid
        addUser(id: uid)

        let sut = makeSUT()

        XCTAssertEqual(sut.cartTotal, 0.0, accuracy: 0.001)
    }

    func test_cartTotal_withOrders_computesCorrectly() {
        let uid = "user-with-orders"
        mockAuth.currentUserUid = uid
        addUserWithOrders(id: uid, orders: [
            (label: "Item A", amount: 2, price: 10.0),
            (label: "Item B", amount: 3, price: 5.0),
            (label: "Item C", amount: 1, price: 20.0)
        ])

        let sut = makeSUT()

        // (2 * 10) + (3 * 5) + (1 * 20) = 20 + 15 + 20 = 55
        XCTAssertEqual(sut.cartTotal, 55.0, accuracy: 0.001)
    }
}
