//
//  CartTableViewCellTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class CartTableViewCellTests: XCTestCase {
    private var sut: CartTableViewCell!

    override func setUp() {
        super.setUp()
        sut = CartTableViewCell(style: .default, reuseIdentifier: "testCell")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func test_init_createsCell() {
        XCTAssertNotNil(sut)
    }

    // MARK: - Accessibility Identifiers

    func test_accessibilityIdentifier_image() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut.contentView, identifier: "cartCell.image")
        XCTAssertNotNil(imageView)
    }

    func test_accessibilityIdentifier_title() {
        let label = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.title")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_price() {
        let label = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.price")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_amount() {
        let label = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.amount")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_stepper() {
        XCTAssertEqual(sut.orderCountStepper.accessibilityIdentifier, "cartCell.stepper")
    }

    // MARK: - Order didSet

    func test_order_setsTitle() {
        let order = makeOrder(label: "Test Product", amount: 2, price: 19.99)
        sut.order = order

        let titleLabel = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.title")
        XCTAssertEqual(titleLabel?.text, "Test Product")
    }

    func test_order_setsAmount() {
        let order = makeOrder(label: "Product", amount: 3, price: 10.0)
        sut.order = order

        let amountLabel = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.amount")
        XCTAssertEqual(amountLabel?.text, "3")
    }

    func test_order_setsPrice() {
        let order = makeOrder(label: "Product", amount: 1, price: 42.5)
        sut.order = order

        let priceLabel = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.price")
        XCTAssertEqual(priceLabel?.text, "42.5")
    }

    func test_order_nilDoesNotCrash() {
        // Default order is nil; accessing subviews should not crash
        let titleLabel = findSubview(ofType: UILabel.self, in: sut.contentView, identifier: "cartCell.title")
        XCTAssertNotNil(titleLabel)
    }

    // MARK: - Stepper

    func test_stepper_minimumValueIsZero() {
        XCTAssertEqual(sut.orderCountStepper.minimumValue, 0)
    }

    // MARK: - Helpers

    private func makeOrder(label: String, amount: Int, price: Double) -> OrderEntity {
        let order = OrderEntity()
        order.productLabel = label
        order.amount = amount
        order.price = price
        return order
    }

    private func findSubview<T: UIView>(ofType type: T.Type, in view: UIView, identifier: String) -> T? {
        if let match = view as? T, match.accessibilityIdentifier == identifier {
            return match
        }
        for subview in view.subviews {
            if let found = findSubview(ofType: type, in: subview, identifier: identifier) {
                return found
            }
        }
        return nil
    }
}
