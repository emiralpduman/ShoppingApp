//
//  ProfileViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class ProfileViewTests: XCTestCase {
    private var sut: ProfileView!

    override func setUp() {
        super.setUp()
        sut = ProfileView(frame: .zero)
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

    func test_accessibilityIdentifier_usernameValue() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.usernameValue")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_emailValue() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.emailValue")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_cartTotalValue() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.cartTotalValue")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_signOutButton() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "profile.signOutButton")
        XCTAssertNotNil(button)
    }

    // MARK: - userName didSet

    func test_userName_updatesLabel() {
        sut.userName = "John"
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.usernameValue")
        XCTAssertEqual(label?.text, "John")
    }

    func test_userName_defaultIsEmpty() {
        XCTAssertEqual(sut.userName, "")
    }

    // MARK: - emailAddress didSet

    func test_emailAddress_updatesLabel() {
        sut.emailAddress = "john@example.com"
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.emailValue")
        XCTAssertEqual(label?.text, "john@example.com")
    }

    func test_emailAddress_defaultIsEmpty() {
        XCTAssertEqual(sut.emailAddress, "")
    }

    // MARK: - cartTotal didSet

    func test_cartTotal_updatesLabel() {
        sut.cartTotal = 150.75
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.cartTotalValue")
        XCTAssertEqual(label?.text, "150.75")
    }

    func test_cartTotal_defaultIsZero() {
        XCTAssertEqual(sut.cartTotal, 0)
    }

    // MARK: - Sign Out Button

    func test_signOutButton_titleIsSignOut() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "profile.signOutButton")
        XCTAssertEqual(button?.title(for: .normal), "Sign Out")
    }

    func test_signOutButton_tintColorIsWhite() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "profile.signOutButton")
        XCTAssertEqual(button?.tintColor, .white)
    }

    // MARK: - Delegate

    func test_delegate_didTapSignOutButton_callsDelegate() {
        let mockDelegate = MockProfileViewDelegate()
        sut.delegate = mockDelegate

        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "profile.signOutButton")
        button?.sendActions(for: .touchDown)

        XCTAssertTrue(mockDelegate.didCallSignOut)
    }

    // MARK: - Multiple Updates

    func test_userName_updatesMultipleTimes() {
        sut.userName = "Alice"
        sut.userName = "Bob"
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "profile.usernameValue")
        XCTAssertEqual(label?.text, "Bob")
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

private class MockProfileViewDelegate: ProfileViewDelegate {
    var didCallSignOut = false

    func didTapSignOutButton() {
        didCallSignOut = true
    }
}
