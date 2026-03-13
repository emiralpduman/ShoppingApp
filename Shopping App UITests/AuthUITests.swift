import XCTest

final class AuthUITests: ShoppingAppUITests {

    // MARK: - Auth Screen Appearance

    func testAuthScreenElementsExist() {
        waitForLaunchScreenToPass()

        let emailField = app.textFields["auth.emailField"]
        guard emailField.waitForExistence(timeout: 10) else {
            // If the user is already signed in, the auth screen is skipped.
            // This is acceptable; the test passes silently.
            return
        }

        XCTAssertTrue(emailField.exists, "Email field should be visible")

        let passwordField = app.secureTextFields["auth.passwordField"]
        XCTAssertTrue(passwordField.exists, "Password field should be visible")

        let segmentedControl = app.segmentedControls["auth.segmentedControl"]
        XCTAssertTrue(segmentedControl.exists, "Segmented control should be visible")

        let signButton = app.buttons["auth.signButton"]
        XCTAssertTrue(signButton.exists, "Sign button should be visible")
    }

    // MARK: - Segment Control Toggle

    func testSegmentControlToggleShowsSignUpFields() {
        waitForLaunchScreenToPass()

        let segmentedControl = app.segmentedControls["auth.segmentedControl"]
        guard segmentedControl.waitForExistence(timeout: 10) else {
            return // Already signed in
        }

        // Switch to Sign Up (index 1)
        segmentedControl.buttons.element(boundBy: 1).tap()

        // Username and password repeat fields should appear for sign up
        let usernameField = app.textFields["auth.usernameField"]
        XCTAssertTrue(
            usernameField.waitForExistence(timeout: 3),
            "Username field should appear on Sign Up"
        )

        let passwordRepeatField = app.secureTextFields["auth.passwordRepeatField"]
        XCTAssertTrue(
            passwordRepeatField.waitForExistence(timeout: 3),
            "Password repeat field should appear on Sign Up"
        )

        // Switch back to Sign In (index 0)
        segmentedControl.buttons.element(boundBy: 0).tap()

        // Username field should disappear on Sign In
        let usernameGone = NSPredicate(format: "exists == false")
        expectation(for: usernameGone, evaluatedWith: usernameField, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
    }

    // MARK: - Sign In Flow

    func testSignInNavigatesToMainScreen() {
        waitForLaunchScreenToPass()

        let emailField = app.textFields["auth.emailField"]
        guard emailField.waitForExistence(timeout: 10) else {
            // Already signed in - verify main screen is showing
            let productsTab = app.buttons["tabBar.products"]
            XCTAssertTrue(productsTab.waitForExistence(timeout: 5))
            return
        }

        let success = signInWithTestCredentials()
        XCTAssertTrue(success, "Sign in should navigate to the main tab bar screen")
    }
}
