//
//  CartViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class CartViewTests: XCTestCase {
    private var sut: CartView!

    override func setUp() {
        super.setUp()
        sut = CartView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func test_init_createsView() {
        XCTAssertNotNil(sut)
    }

    // MARK: - Accessibility Identifiers

    func test_accessibilityIdentifier_tableView() {
        XCTAssertEqual(sut.ordersTableView.accessibilityIdentifier, "cart.tableView")
    }

    func test_accessibilityIdentifier_totalLabel() {
        XCTAssertEqual(sut.totalLabel.accessibilityIdentifier, "cart.totalLabel")
    }

    func test_accessibilityIdentifier_totalNumber() {
        XCTAssertEqual(sut.totalNumberLabel.accessibilityIdentifier, "cart.totalNumber")
    }

    func test_accessibilityIdentifier_payButton() {
        XCTAssertEqual(sut.payButton.accessibilityIdentifier, "cart.payButton")
    }

    // MARK: - cartTotal didSet

    func test_cartTotal_updatesLabel() {
        sut.cartTotal = 99.99
        XCTAssertEqual(sut.totalNumberLabel.text, "99.99")
    }

    func test_cartTotal_defaultIsZero() {
        XCTAssertEqual(sut.cartTotal, 0)
    }

    func test_cartTotal_updatesLabelMultipleTimes() {
        sut.cartTotal = 10.0
        XCTAssertEqual(sut.totalNumberLabel.text, "10.0")
        sut.cartTotal = 25.5
        XCTAssertEqual(sut.totalNumberLabel.text, "25.5")
    }

    // MARK: - Subviews

    func test_tableView_isAddedAsSubview() {
        XCTAssertTrue(sut.subviews.contains(sut.ordersTableView))
    }

    func test_payButton_titleIsPay() {
        XCTAssertEqual(sut.payButton.title(for: .normal), "Pay")
    }

    func test_totalLabel_textIsTotal() {
        XCTAssertEqual(sut.totalLabel.text, "Total:")
    }

    // MARK: - Delegate

    func test_delegate_didTapPayButton_callsDelegate() {
        let mockDelegate = MockCartViewDelegate()
        sut.delegate = mockDelegate

        sut.didTapPayButton()

        XCTAssertTrue(mockDelegate.didCallPayButton)
    }

    // MARK: - TableView Connections

    func test_setTableViewConnections_setsDelegate() {
        let tableDelegate = MockTableViewDelegate()
        sut.setTableViewConnections(delegate: tableDelegate, dataSource: tableDelegate)

        XCTAssertTrue(sut.ordersTableView.delegate === tableDelegate)
        XCTAssertTrue(sut.ordersTableView.dataSource === tableDelegate)
    }
}

// MARK: - Mock Delegates

private class MockCartViewDelegate: CartViewDelegate {
    var didCallPayButton = false

    func didTapPayButton() {
        didCallPayButton = true
    }
}

private class MockTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
