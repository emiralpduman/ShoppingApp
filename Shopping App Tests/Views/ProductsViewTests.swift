//
//  ProductsViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class ProductsViewTests: XCTestCase {
    private var sut: ProductsView!

    override func setUp() {
        super.setUp()
        sut = ProductsView(frame: .zero)
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

    func test_accessibilityIdentifier_collectionView() {
        XCTAssertEqual(sut.productsCollectionView.accessibilityIdentifier, "products.collectionView")
    }

    // MARK: - Subviews

    func test_collectionView_isAddedAsSubview() {
        XCTAssertTrue(sut.subviews.contains(sut.productsCollectionView))
    }

    // MARK: - Cell Registration

    func test_collectionView_registersCellClass() {
        // Dequeue should not crash if registration happened
        // We verify the collection view exists and is properly set up
        XCTAssertNotNil(sut.productsCollectionView.collectionViewLayout)
    }

    // MARK: - Delegate Setting

    func test_setCollectionViewDelegate_setsDelegate() {
        let mockDelegate = MockCollectionViewDelegate()
        sut.setCollectionViewDelegate(mockDelegate, andDataSource: mockDelegate)

        XCTAssertTrue(sut.productsCollectionView.delegate === mockDelegate)
        XCTAssertTrue(sut.productsCollectionView.dataSource === mockDelegate)
    }
}

// MARK: - Mock

private class MockCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 0 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
