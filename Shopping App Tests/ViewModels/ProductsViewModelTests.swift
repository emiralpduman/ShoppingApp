import XCTest
import RealmSwift
@testable import Shopping_App

final class ProductsViewModelTests: XCTestCase {

    // MARK: - Helpers

    private func makeProduct(id: Int = 1,
                             title: String = "Test Product",
                             price: Double = 19.99,
                             desc: String = "A description",
                             category: String = "electronics",
                             image: String = "https://example.com/image.png") -> ProductEntity {
        let product = ProductEntity()
        product._id = id
        product.title = title
        product.price = price
        product.desc = desc
        product.category = category
        product.image = image
        return product
    }

    // MARK: - Products Array

    func test_productsArray_canBeSetDirectly() {
        let viewModel = ProductsViewModel()
        let product = makeProduct()

        viewModel.products = [product]

        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Test Product")
    }

    func test_emptyProducts_hasZeroCount() {
        let viewModel = ProductsViewModel()

        viewModel.products = []

        XCTAssertTrue(viewModel.products.isEmpty)
    }

    func test_multipleProducts_preservesOrder() {
        let viewModel = ProductsViewModel()
        let product1 = makeProduct(id: 1, title: "First")
        let product2 = makeProduct(id: 2, title: "Second")
        let product3 = makeProduct(id: 3, title: "Third")

        viewModel.products = [product1, product2, product3]

        XCTAssertEqual(viewModel.products.count, 3)
        XCTAssertEqual(viewModel.products[0].title, "First")
        XCTAssertEqual(viewModel.products[1].title, "Second")
        XCTAssertEqual(viewModel.products[2].title, "Third")
    }

    // MARK: - Delegate

    func test_delegate_isInitiallyNil() {
        let viewModel = ProductsViewModel()

        XCTAssertNil(viewModel.delegate)
    }

    func test_delegate_isWeaklyHeld() {
        let viewModel = ProductsViewModel()

        autoreleasepool {
            let delegate = MockProductsDelegate()
            viewModel.delegate = delegate
            XCTAssertNotNil(viewModel.delegate)
        }

        XCTAssertNil(viewModel.delegate)
    }

    // MARK: - Realm Integration

    func test_init_loadsProductsFromRealm() {
        let realm = InMemoryRealmHelper.makeRealm()
        // swiftlint:disable:next force_try
        try! realm.write {
            let product1 = makeProduct(id: 1, title: "From Realm")
            let product2 = makeProduct(id: 2, title: "Also From Realm")
            realm.add(product1)
            realm.add(product2)
        }

        let viewModel = ProductsViewModel(realm: realm)

        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertTrue(viewModel.products.contains(where: { $0.title == "From Realm" }))
        XCTAssertTrue(viewModel.products.contains(where: { $0.title == "Also From Realm" }))
    }

    func test_init_emptyRealm_productsIsEmpty() {
        let realm = InMemoryRealmHelper.makeRealm()

        let viewModel = ProductsViewModel(realm: realm)

        XCTAssertTrue(viewModel.products.isEmpty)
    }
}

// MARK: - Mock Delegate

private final class MockProductsDelegate: ProductsViewModelDelegate {
    var didFetchProductsCalled = false
    var lastError: Error?

    func didErrorOccur(_ error: Error) {
        lastError = error
    }

    func didFetchProducts() {
        didFetchProductsCalled = true
    }
}
