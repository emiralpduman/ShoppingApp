import XCTest

final class ProfileUITests: ShoppingAppUITests {

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigateToMainScreen()
    }

    // MARK: - Helpers

    private func switchToProfileTab() {
        let profileTab = app.buttons["tabBar.profile"]
        guard profileTab.waitForExistence(timeout: 5) else {
            XCTFail("Profile tab not found")
            return
        }
        profileTab.tap()
    }

    // MARK: - Profile Screen Elements

    func testProfileScreenDisplaysUserInfo() {
        switchToProfileTab()

        let usernameValue = app.staticTexts["profile.usernameValue"]
        XCTAssertTrue(
            usernameValue.waitForExistence(timeout: 5),
            "Username value should be visible on profile screen"
        )

        let emailValue = app.staticTexts["profile.emailValue"]
        XCTAssertTrue(
            emailValue.waitForExistence(timeout: 3),
            "Email value should be visible on profile screen"
        )

        let cartTotalValue = app.staticTexts["profile.cartTotalValue"]
        XCTAssertTrue(
            cartTotalValue.waitForExistence(timeout: 3),
            "Cart total value should be visible on profile screen"
        )
    }

    // MARK: - Sign Out

    func testSignOutButtonExists() {
        switchToProfileTab()

        let signOutButton = app.buttons["profile.signOutButton"]
        XCTAssertTrue(
            signOutButton.waitForExistence(timeout: 5),
            "Sign out button should be visible on profile screen"
        )
    }

    func testSignOutNavigatesToAuthScreen() {
        switchToProfileTab()

        let signOutButton = app.buttons["profile.signOutButton"]
        guard signOutButton.waitForExistence(timeout: 5) else {
            XCTFail("Sign out button not found")
            return
        }

        signOutButton.tap()

        // After sign out, the auth screen should appear
        let emailField = app.textFields["auth.emailField"]
        XCTAssertTrue(
            emailField.waitForExistence(timeout: 10),
            "Auth screen should appear after signing out"
        )
    }

    // MARK: - Tab Navigation

    func testTabBarNavigationBetweenTabs() {
        // Start on Products tab
        let productsTab = app.buttons["tabBar.products"]
        XCTAssertTrue(productsTab.waitForExistence(timeout: 5))

        // Switch to Profile tab
        let profileTab = app.buttons["tabBar.profile"]
        profileTab.tap()

        let signOutButton = app.buttons["profile.signOutButton"]
        XCTAssertTrue(
            signOutButton.waitForExistence(timeout: 5),
            "Profile screen should appear when profile tab is tapped"
        )

        // Switch back to Products tab
        productsTab.tap()

        let collectionView = app.collectionViews["products.collectionView"]
        XCTAssertTrue(
            collectionView.waitForExistence(timeout: 5),
            "Products screen should appear when products tab is tapped"
        )
    }
}
