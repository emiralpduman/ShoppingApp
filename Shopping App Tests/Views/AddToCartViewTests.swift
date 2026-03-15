//
//  AddToCartViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class AddToCartViewTests: XCTestCase {
    private var sut: AddToCartView!

    override func setUp() {
        super.setUp()
        sut = AddToCartView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func test_init_createsView() {
        XCTAssertNotNil(sut)
    }

    func test_init_hasBorder() {
        XCTAssertEqual(sut.layer.borderWidth, 1)
        XCTAssertEqual(sut.layer.borderColor, UIColor.black.cgColor)
    }

    // MARK: - Accessibility Identifiers

    func test_accessibilityIdentifier_stepper() {
        let stepper = findSubview(ofType: UIStepper.self, in: sut, identifier: "addToCart.stepper")
        XCTAssertNotNil(stepper)
    }

    func test_accessibilityIdentifier_quantityLabel() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "addToCart.quantityLabel")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_addButton() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "addToCart.addButton")
        XCTAssertNotNil(button)
    }

    // MARK: - Quantity didSet

    func test_quantity_defaultIsZero() {
        XCTAssertEqual(sut.quantity, 0)
    }

    func test_quantity_updatesLabel() {
        sut.quantity = 5

        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "addToCart.quantityLabel")
        XCTAssertEqual(label?.text, "Amount: 5")
    }

    func test_quantity_updatesLabelMultipleTimes() {
        sut.quantity = 3
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "addToCart.quantityLabel")
        XCTAssertEqual(label?.text, "Amount: 3")

        sut.quantity = 10
        XCTAssertEqual(label?.text, "Amount: 10")
    }

    func test_quantity_defaultLabelText() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "addToCart.quantityLabel")
        XCTAssertEqual(label?.text, "Amount: 0")
    }

    // MARK: - Add Button

    func test_addButton_titleIsAdd() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "addToCart.addButton")
        XCTAssertEqual(button?.title(for: .normal), "Add")
    }

    func test_addButton_tintColorIsWhite() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "addToCart.addButton")
        XCTAssertEqual(button?.tintColor, .white)
    }

    // MARK: - Stepper

    func test_stepper_minimumValueIsZero() {
        let stepper = findSubview(ofType: UIStepper.self, in: sut, identifier: "addToCart.stepper")
        XCTAssertEqual(stepper?.minimumValue, 0)
    }

    // MARK: - Delegate

    func test_delegate_didTapAddButton_callsDelegate() {
        let mockDelegate = MockAddToCartViewDelegate()
        sut.delegate = mockDelegate

        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "addToCart.addButton")
        button?.sendActions(for: .touchUpInside)

        XCTAssertTrue(mockDelegate.didCallAddButton)
    }

    func test_delegate_didTapStepper_callsDelegate() {
        let mockDelegate = MockAddToCartViewDelegate()
        sut.delegate = mockDelegate

        let stepper = findSubview(ofType: UIStepper.self, in: sut, identifier: "addToCart.stepper")
        stepper?.sendActions(for: .valueChanged)

        XCTAssertTrue(mockDelegate.didCallStepper)
    }

    // MARK: - Gesture Recognizer

    func test_init_hasSwipeGestureRecognizer() {
        let swipeRecognizers = sut.gestureRecognizers?.compactMap { $0 as? UISwipeGestureRecognizer } ?? []
        XCTAssertFalse(swipeRecognizers.isEmpty)
    }

    func test_swipeGesture_directionIsDown() {
        let swipeRecognizer = sut.gestureRecognizers?.compactMap({ $0 as? UISwipeGestureRecognizer }).first
        XCTAssertEqual(swipeRecognizer?.direction, .down)
    }

    // MARK: - Helpers

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

// MARK: - Mock Delegate

private class MockAddToCartViewDelegate: AddToCartViewDelegate {
    var didCallStepper = false
    var didCallAddButton = false
    var didCallSwipeDown = false

    func addToCartView(_ view: AddToCartView, didTapQuantityStepper: UIStepper) {
        didCallStepper = true
    }

    func addToCartView(_ view: AddToCartView, didTapAddButton: UIButton) {
        didCallAddButton = true
    }

    func didSwipeDown() {
        didCallSwipeDown = true
    }
}
