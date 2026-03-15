//
//  ProductDetailViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class ProductDetailViewTests: XCTestCase {
    private var sut: ProductDetailView!

    override func setUp() {
        super.setUp()
        sut = ProductDetailView(frame: .zero)
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

    func test_accessibilityIdentifier_image() {
        XCTAssertEqual(sut.productImageView.accessibilityIdentifier, "productDetail.image")
    }

    func test_accessibilityIdentifier_name() {
        XCTAssertEqual(sut.productNameLabel.accessibilityIdentifier, "productDetail.name")
    }

    func test_accessibilityIdentifier_price() {
        XCTAssertEqual(sut.productPriceLabel.accessibilityIdentifier, "productDetail.price")
    }

    func test_accessibilityIdentifier_description() {
        XCTAssertEqual(sut.productDescriptionLabel.accessibilityIdentifier, "productDetail.description")
    }

    func test_accessibilityIdentifier_category() {
        XCTAssertEqual(sut.productCategoryLabel.accessibilityIdentifier, "productDetail.category")
    }

    func test_accessibilityIdentifier_ratingRate() {
        XCTAssertEqual(sut.productRatingRateLabel.accessibilityIdentifier, "productDetail.ratingRate")
    }

    func test_accessibilityIdentifier_ratingCount() {
        XCTAssertEqual(sut.productRatingCountLabel.accessibilityIdentifier, "productDetail.ratingCount")
    }

    func test_accessibilityIdentifier_addToCartButton() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "productDetail.addToCartButton")
        XCTAssertNotNil(button)
    }

    // MARK: - Subviews Exist

    func test_imageView_isAddedAsSubview() {
        XCTAssertTrue(sut.subviews.contains(sut.productImageView))
    }

    func test_imageView_contentModeIsAspectFit() {
        XCTAssertEqual(sut.productImageView.contentMode, .scaleAspectFit)
    }

    // MARK: - Label Fonts

    func test_nameLabel_usesHeadlineFont() {
        XCTAssertEqual(sut.productNameLabel.font, UIFont.preferredFont(forTextStyle: .headline))
    }

    func test_priceLabel_usesSubheadlineFont() {
        XCTAssertEqual(sut.productPriceLabel.font, UIFont.preferredFont(forTextStyle: .subheadline))
    }

    // MARK: - Add to Cart Button

    func test_addToCartButton_titleIsAddToCart() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "productDetail.addToCartButton")
        XCTAssertEqual(button?.title(for: .normal), "Add to Cart")
    }

    func test_addToCartButton_tintColorIsWhite() {
        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "productDetail.addToCartButton")
        XCTAssertEqual(button?.tintColor, .white)
    }

    // MARK: - Delegate

    func test_delegate_didTapAddToCartButton_callsDelegate() {
        let mockDelegate = MockProductDetailViewDelegate()
        sut.delegate = mockDelegate

        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "productDetail.addToCartButton")
        button?.sendActions(for: .touchUpInside)

        XCTAssertTrue(mockDelegate.didCallAddToCart)
    }

    func test_delegate_didTapAddToCartButton_passesCorrectView() {
        let mockDelegate = MockProductDetailViewDelegate()
        sut.delegate = mockDelegate

        let button = findSubview(ofType: UIButton.self, in: sut, identifier: "productDetail.addToCartButton")
        button?.sendActions(for: .touchUpInside)

        XCTAssertTrue(mockDelegate.receivedView === sut)
    }

    // MARK: - Alignment Rect Insets

    func test_alignmentRectInsets_areUniform() {
        let insets = sut.alignmentRectInsets
        XCTAssertEqual(insets.top, 10)
        XCTAssertEqual(insets.left, 10)
        XCTAssertEqual(insets.bottom, 10)
        XCTAssertEqual(insets.right, 10)
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

private class MockProductDetailViewDelegate: ProductDetailViewDelegate {
    var didCallAddToCart = false
    var receivedView: ProductDetailView?

    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton: UIButton) {
        didCallAddToCart = true
        receivedView = view
    }
}
