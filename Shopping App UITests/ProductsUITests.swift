import XCTest

final class ProductsUITests: ShoppingAppUITests {

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigateToMainScreen()
    }

    // MARK: - Products Grid

    func testProductsCollectionViewLoads() {
        let collectionView = app.collectionViews["products.collectionView"]
        XCTAssertTrue(
            collectionView.waitForExistence(timeout: 10),
            "Products collection view should be visible"
        )

        // Wait for at least one cell to appear (network fetch)
        let firstCell = collectionView.cells.firstMatch
        XCTAssertTrue(
            firstCell.waitForExistence(timeout: 15),
            "At least one product cell should load"
        )
    }

    // MARK: - Product Detail

    func testTapProductShowsDetail() {
        let collectionView = app.collectionViews["products.collectionView"]
        guard collectionView.waitForExistence(timeout: 10) else {
            XCTFail("Products collection view not found")
            return
        }

        let firstCell = collectionView.cells.firstMatch
        guard firstCell.waitForExistence(timeout: 15) else {
            XCTFail("No product cells loaded")
            return
        }

        firstCell.tap()

        // Verify detail elements appear
        let detailName = app.staticTexts["productDetail.name"]
        XCTAssertTrue(
            detailName.waitForExistence(timeout: 5),
            "Product detail name should be visible"
        )

        let detailPrice = app.staticTexts["productDetail.price"]
        XCTAssertTrue(detailPrice.exists, "Product detail price should be visible")

        let addToCartButton = app.buttons["productDetail.addToCartButton"]
        XCTAssertTrue(addToCartButton.exists, "Add to cart button should be visible")
    }

    // MARK: - Add to Cart Flow

    func testAddToCartFlowFromProductDetail() {
        let collectionView = app.collectionViews["products.collectionView"]
        guard collectionView.waitForExistence(timeout: 10) else {
            XCTFail("Products collection view not found")
            return
        }

        let firstCell = collectionView.cells.firstMatch
        guard firstCell.waitForExistence(timeout: 15) else {
            XCTFail("No product cells loaded")
            return
        }

        firstCell.tap()

        let addToCartButton = app.buttons["productDetail.addToCartButton"]
        guard addToCartButton.waitForExistence(timeout: 5) else {
            XCTFail("Add to cart button not found on detail")
            return
        }

        addToCartButton.tap()

        // The add-to-cart modal should appear
        let quantityLabel = app.staticTexts["addToCart.quantityLabel"]
        XCTAssertTrue(
            quantityLabel.waitForExistence(timeout: 5),
            "Quantity label should appear in add-to-cart modal"
        )

        let addButton = app.buttons["addToCart.addButton"]
        XCTAssertTrue(addButton.exists, "Add button should be visible in add-to-cart modal")

        let stepper = app.steppers["addToCart.stepper"]
        XCTAssertTrue(stepper.exists, "Stepper should be visible in add-to-cart modal")
    }

    // MARK: - Navigation to Cart via Nav Bar

    func testCartButtonInNavigationBar() {
        let cartButton = app.buttons["navBar.cartButton"]
        XCTAssertTrue(
            cartButton.waitForExistence(timeout: 5),
            "Cart button should exist in the navigation bar"
        )

        cartButton.tap()

        // Cart view should appear
        let cartTableView = app.tables["cart.tableView"]
        XCTAssertTrue(
            cartTableView.waitForExistence(timeout: 5),
            "Cart table view should appear after tapping cart button"
        )
    }
}
