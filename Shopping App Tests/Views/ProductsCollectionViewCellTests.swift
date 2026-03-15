//
//  ProductsCollectionViewCellTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class ProductsCollectionViewCellTests: XCTestCase {
    private var sut: ProductsCollectionViewCell!

    override func setUp() {
        super.setUp()
        sut = ProductsCollectionViewCell(frame: .zero)
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
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "productCell.image")
        XCTAssertNotNil(imageView)
    }

    func test_accessibilityIdentifier_name() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.name")
        XCTAssertNotNil(label)
    }

    func test_accessibilityIdentifier_price() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.price")
        XCTAssertNotNil(label)
    }

    // MARK: - Drawing Constants

    func test_cornerRadius_value() {
        XCTAssertEqual(sut.cornerRadius, 50)
    }

    func test_labelHorizontalInset_value() {
        XCTAssertEqual(sut.labelHorizontalInsetWRTImage, 40)
    }

    func test_labelVerticalInset_value() {
        XCTAssertEqual(sut.labelVerticalInsetWRTImage, 10)
    }

    // MARK: - Product didSet

    func test_product_setsNameLabel() {
        let product = makeProduct(title: "Test Shirt", price: 29.99, image: "https://example.com/img.png")
        sut.product = product

        let nameLabel = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.name")
        XCTAssertEqual(nameLabel?.text, "Test Shirt")
    }

    func test_product_setsPriceLabel() {
        let product = makeProduct(title: "Product", price: 15.0, image: "https://example.com/img.png")
        sut.product = product

        let priceLabel = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.price")
        XCTAssertEqual(priceLabel?.text, "15.0")
    }

    // MARK: - Image View Properties

    func test_imageView_contentModeIsAspectFit() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "productCell.image")
        XCTAssertEqual(imageView?.contentMode, .scaleAspectFit)
    }

    func test_imageView_clipsContent() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "productCell.image")
        XCTAssertTrue(imageView?.clipsToBounds ?? false)
    }

    // MARK: - Label Colors

    func test_nameLabel_textColorIsWhite() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.name")
        XCTAssertEqual(label?.textColor, .white)
    }

    func test_priceLabel_textColorIsWhite() {
        let label = findSubview(ofType: UILabel.self, in: sut, identifier: "productCell.price")
        XCTAssertEqual(label?.textColor, .white)
    }

    // MARK: - Helpers

    private func makeProduct(title: String, price: Double, image: String) -> ProductEntity {
        let product = ProductEntity()
        product.title = title
        product.price = price
        product.image = image
        return product
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
