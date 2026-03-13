import XCTest

final class CartUITests: ShoppingAppUITests {

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigateToMainScreen()
    }

    // MARK: - Helpers

    /// Adds the first product to cart so the cart is not empty for testing.
    private func addFirstProductToCart() {
        let collectionView = app.collectionViews["products.collectionView"]
        guard collectionView.waitForExistence(timeout: 10) else { return }

        let firstCell = collectionView.cells.firstMatch
        guard firstCell.waitForExistence(timeout: 15) else { return }

        firstCell.tap()

        let addToCartButton = app.buttons["productDetail.addToCartButton"]
        guard addToCartButton.waitForExistence(timeout: 5) else { return }
        addToCartButton.tap()

        let addButton = app.buttons["addToCart.addButton"]
        guard addButton.waitForExistence(timeout: 5) else { return }
        addButton.tap()
    }

    /// Navigates to the cart screen via the navigation bar button.
    private func openCart() {
        let cartButton = app.buttons["navBar.cartButton"]
        guard cartButton.waitForExistence(timeout: 5) else { return }
        cartButton.tap()
    }

    // MARK: - Cart View Elements

    func testCartViewElementsExist() {
        openCart()

        let cartTableView = app.tables["cart.tableView"]
        XCTAssertTrue(
            cartTableView.waitForExistence(timeout: 5),
            "Cart table view should be visible"
        )

        let totalLabel = app.staticTexts["cart.totalLabel"]
        XCTAssertTrue(totalLabel.exists, "Total label should be visible")

        let totalNumber = app.staticTexts["cart.totalNumber"]
        XCTAssertTrue(totalNumber.exists, "Total number should be visible")

        let payButton = app.buttons["cart.payButton"]
        XCTAssertTrue(payButton.exists, "Pay button should be visible")
    }

    // MARK: - Cart with Item

    func testCartShowsAddedItem() {
        addFirstProductToCart()
        openCart()

        let cartTableView = app.tables["cart.tableView"]
        guard cartTableView.waitForExistence(timeout: 5) else {
            XCTFail("Cart table view not found")
            return
        }

        // There should be at least one cell in the cart
        let firstCartCell = cartTableView.cells.firstMatch
        XCTAssertTrue(
            firstCartCell.waitForExistence(timeout: 5),
            "Cart should contain at least one item after adding a product"
        )
    }

    // MARK: - Pay Button

    func testPayButtonExists() {
        openCart()

        let payButton = app.buttons["cart.payButton"]
        XCTAssertTrue(
            payButton.waitForExistence(timeout: 5),
            "Pay button should be visible in cart"
        )
    }
}
