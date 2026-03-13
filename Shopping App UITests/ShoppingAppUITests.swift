import XCTest

class ShoppingAppUITests: XCTestCase {

    var app: XCUIApplication!

    // MARK: - Test Credentials

    static let testEmail = "uitest@example.com"
    static let testPassword = "Test1234"
    static let testUsername = "UITestUser"

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Helpers

    /// Waits for the launch screen activity indicator to disappear,
    /// indicating that the app has finished loading data and navigated away.
    func waitForLaunchScreenToPass(timeout: TimeInterval = 15) {
        let launchIndicator = app.activityIndicators["launch.activityIndicator"]
        // If the launch indicator exists, wait for it to disappear
        if launchIndicator.exists {
            let gone = NSPredicate(format: "exists == false")
            expectation(for: gone, evaluatedWith: launchIndicator, handler: nil)
            waitForExpectations(timeout: timeout, handler: nil)
        }
    }

    /// Attempts to sign in with the test credentials.
    /// Assumes the Auth screen is currently visible.
    /// Returns true if sign-in navigation appeared to succeed.
    @discardableResult
    func signInWithTestCredentials(timeout: TimeInterval = 10) -> Bool {
        let emailField = app.textFields["auth.emailField"]
        guard emailField.waitForExistence(timeout: timeout) else {
            return false
        }

        // Make sure we are on the Sign In segment (index 0)
        let segmentedControl = app.segmentedControls["auth.segmentedControl"]
        if segmentedControl.exists {
            segmentedControl.buttons.element(boundBy: 0).tap()
        }

        // Clear and type email
        emailField.tap()
        emailField.clearAndTypeText(ShoppingAppUITests.testEmail)

        // Clear and type password
        let passwordField = app.secureTextFields["auth.passwordField"]
        if passwordField.waitForExistence(timeout: 3) {
            passwordField.tap()
            passwordField.clearAndTypeText(ShoppingAppUITests.testPassword)
        }

        // Tap sign in
        let signButton = app.buttons["auth.signButton"]
        if signButton.exists && signButton.isEnabled {
            signButton.tap()
        }

        // Wait for the tab bar to appear, indicating successful sign-in
        let productsTab = app.buttons["tabBar.products"]
        return productsTab.waitForExistence(timeout: timeout)
    }

    /// Navigates through launch and auth to reach the main tab bar.
    /// Call this from tests that need the user to be signed in.
    func navigateToMainScreen(timeout: TimeInterval = 15) {
        waitForLaunchScreenToPass(timeout: timeout)

        // Check if already on main screen
        let productsTab = app.buttons["tabBar.products"]
        if productsTab.waitForExistence(timeout: 3) {
            return
        }

        // Otherwise attempt sign in
        signInWithTestCredentials(timeout: timeout)
    }
}

// MARK: - XCUIElement Helpers

extension XCUIElement {
    /// Clears existing text and types new text into a text field.
    func clearAndTypeText(_ text: String) {
        guard let currentValue = self.value as? String, !currentValue.isEmpty else {
            self.typeText(text)
            return
        }
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}
