//
//  AuthViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class AuthViewTests: XCTestCase {
    private var sut: AuthView!

    override func setUp() {
        super.setUp()
        sut = AuthView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func test_init_createsView() {
        XCTAssertNotNil(sut)
    }

    func test_init_backgroundColorIsWhite() {
        XCTAssertEqual(sut.backgroundColor, .white)
    }

    // MARK: - Accessibility Identifiers

    func test_accessibilityIdentifier_emailField() {
        XCTAssertEqual(sut.emailTextField.accessibilityIdentifier, "auth.emailField")
    }

    func test_accessibilityIdentifier_passwordField() {
        XCTAssertEqual(sut.passwordTextField.accessibilityIdentifier, "auth.passwordField")
    }

    func test_accessibilityIdentifier_usernameField() {
        XCTAssertEqual(sut.userNameTextField.accessibilityIdentifier, "auth.usernameField")
    }

    func test_accessibilityIdentifier_passwordRepeatField() {
        XCTAssertEqual(sut.passwordRepeatTextField.accessibilityIdentifier, "auth.passwordRepeatField")
    }

    func test_accessibilityIdentifier_activityIndicator() {
        XCTAssertEqual(sut.activityIndicator.accessibilityIdentifier, "auth.activityIndicator")
    }

    func test_segmentedControl_hasAccessibilityIdentifier() {
        let segmented = findSubview(ofType: UISegmentedControl.self, in: sut, identifier: "auth.segmentedControl")
        XCTAssertNotNil(segmented)
    }

    func test_signButton_hasAccessibilityIdentifier() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "auth.signButton")
        XCTAssertNotNil(button)
    }

    // MARK: - Default State

    func test_defaultSigningMode_isSignIn() {
        XCTAssertEqual(sut.signingMode, .signIn)
    }

    func test_defaultState_usernameFieldIsHidden() {
        XCTAssertTrue(sut.userNameTextField.isHidden)
    }

    func test_defaultState_passwordRepeatFieldIsHidden() {
        XCTAssertTrue(sut.passwordRepeatTextField.isHidden)
    }

    func test_defaultState_signButtonTitleIsSignIn() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "auth.signButton")
        XCTAssertEqual(button?.title(for: .normal), "Sign-In")
    }

    // MARK: - SigningMode Toggle

    func test_signingMode_signUp_showsUsernameField() {
        sut.signingMode = .signUp
        XCTAssertFalse(sut.userNameTextField.isHidden)
    }

    func test_signingMode_signUp_showsPasswordRepeatField() {
        sut.signingMode = .signUp
        XCTAssertFalse(sut.passwordRepeatTextField.isHidden)
    }

    func test_signingMode_signUp_updatesButtonTitle() {
        sut.signingMode = .signUp
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "auth.signButton")
        XCTAssertEqual(button?.title(for: .normal), "Sign-Up")
    }

    func test_signingMode_signIn_hidesUsernameField() {
        sut.signingMode = .signUp
        sut.signingMode = .signIn
        XCTAssertTrue(sut.userNameTextField.isHidden)
    }

    func test_signingMode_signIn_hidesPasswordRepeatField() {
        sut.signingMode = .signUp
        sut.signingMode = .signIn
        XCTAssertTrue(sut.passwordRepeatTextField.isHidden)
    }

    func test_signingMode_signIn_updatesButtonTitle() {
        sut.signingMode = .signUp
        sut.signingMode = .signIn
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "auth.signButton")
        XCTAssertEqual(button?.title(for: .normal), "Sign-In")
    }

    // MARK: - TextField Properties

    func test_emailTextField_disablesAutocapitalization() {
        XCTAssertEqual(sut.emailTextField.autocapitalizationType, .none)
    }

    func test_passwordTextField_isSecure() {
        XCTAssertTrue(sut.passwordTextField.isSecureTextEntry)
    }

    func test_passwordRepeatTextField_isSecure() {
        XCTAssertTrue(sut.passwordRepeatTextField.isSecureTextEntry)
    }

    // MARK: - Delegate

    func test_delegate_buttonPressed_callsDelegate() {
        let mockDelegate = MockAuthViewDelegate()
        sut.delegate = mockDelegate

        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "auth.signButton")
        button?.sendActions(for: .touchDown)

        XCTAssertTrue(mockDelegate.didCallButtonPressed)
    }

    func test_delegate_segmentedControlValueChange_callsDelegate() {
        let mockDelegate = MockAuthViewDelegate()
        sut.delegate = mockDelegate

        let segmented = findSubview(ofType: UISegmentedControl.self, in: sut, identifier: "auth.segmentedControl")
        segmented?.selectedSegmentIndex = 1
        segmented?.sendActions(for: .valueChanged)

        XCTAssertTrue(mockDelegate.didCallValueChange)
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

private class MockAuthViewDelegate: AuthViewDelegate {
    var didCallValueChange = false
    var didCallButtonPressed = false

    func didValueChange(_ sender: UISegmentedControl) {
        didCallValueChange = true
    }

    func didButtonPressed(_ sender: UIButton) {
        didCallButtonPressed = true
    }
}
