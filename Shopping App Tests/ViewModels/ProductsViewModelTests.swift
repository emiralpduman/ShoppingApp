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

    private func makeRealm(with products: [ProductEntity]) -> Realm {
        let realm = InMemoryRealmHelper.makeRealm()
        // swiftlint:disable:next force_try
        try! realm.write {
            products.forEach { realm.add($0) }
        }
        return realm
    }

    // MARK: - Products Array

    func test_init_loadsProductsFromRealm() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "From Realm"),
            makeProduct(id: 2, title: "Also From Realm")
        ])

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

    func test_init_allProductsMatchesProducts() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "First"),
            makeProduct(id: 2, title: "Second"),
            makeProduct(id: 3, title: "Third")
        ])

        let viewModel = ProductsViewModel(realm: realm)

        XCTAssertEqual(viewModel.allProducts.count, 3)
        XCTAssertEqual(viewModel.products.count, viewModel.allProducts.count)
    }

    // MARK: - Categories

    func test_init_categoriesIncludesAll() {
        let realm = makeRealm(with: [makeProduct(category: "electronics")])

        let viewModel = ProductsViewModel(realm: realm)

        XCTAssertTrue(viewModel.categories.contains("All"))
    }

    func test_init_categoriesAreDeduplicatedAndSorted() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, category: "clothing"),
            makeProduct(id: 2, category: "electronics"),
            makeProduct(id: 3, category: "clothing")
        ])

        let viewModel = ProductsViewModel(realm: realm)

        XCTAssertEqual(viewModel.categories, ["All", "clothing", "electronics"])
    }

    func test_init_emptyRealm_categoriesOnlyContainsAll() {
        let viewModel = ProductsViewModel(realm: InMemoryRealmHelper.makeRealm())

        XCTAssertEqual(viewModel.categories, ["All"])
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

    // MARK: - filterProducts: search text

    func test_filterProducts_emptySearchText_returnsAll() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple"),
            makeProduct(id: 2, title: "Banana")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "", category: nil)

        XCTAssertEqual(viewModel.products.count, 2)
    }

    func test_filterProducts_matchingSearchText_returnsMatchingProducts() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple Watch"),
            makeProduct(id: 2, title: "Banana Phone"),
            makeProduct(id: 3, title: "Apple iPhone")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "Apple", category: nil)

        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertTrue(viewModel.products.allSatisfy { $0.title.contains("Apple") })
    }

    func test_filterProducts_searchIsCaseInsensitive() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple Watch"),
            makeProduct(id: 2, title: "Banana")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "apple", category: nil)

        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Apple Watch")
    }

    func test_filterProducts_noMatch_returnsEmpty() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple"),
            makeProduct(id: 2, title: "Banana")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "xyz123", category: nil)

        XCTAssertTrue(viewModel.products.isEmpty)
    }

    // MARK: - filterProducts: category

    func test_filterProducts_categoryAll_returnsAll() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, category: "electronics"),
            makeProduct(id: 2, category: "clothing")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "", category: "All")

        XCTAssertEqual(viewModel.products.count, 2)
    }

    func test_filterProducts_nilCategory_returnsAll() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, category: "electronics"),
            makeProduct(id: 2, category: "clothing")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "", category: nil)

        XCTAssertEqual(viewModel.products.count, 2)
    }

    func test_filterProducts_specificCategory_returnsOnlyMatching() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, category: "electronics"),
            makeProduct(id: 2, category: "clothing"),
            makeProduct(id: 3, category: "electronics")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "", category: "electronics")

        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertTrue(viewModel.products.allSatisfy { $0.category == "electronics" })
    }

    // MARK: - filterProducts: combined

    func test_filterProducts_searchAndCategory_appliesBothFilters() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple Watch", category: "electronics"),
            makeProduct(id: 2, title: "Apple Shirt", category: "clothing"),
            makeProduct(id: 3, title: "Banana Phone", category: "electronics")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "Apple", category: "electronics")

        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Apple Watch")
    }

    // MARK: - filterProducts: state

    func test_filterProducts_updatesCurrentSearchText() {
        let viewModel = ProductsViewModel(realm: InMemoryRealmHelper.makeRealm())

        viewModel.filterProducts(searchText: "hello", category: nil)

        XCTAssertEqual(viewModel.currentSearchText, "hello")
    }

    func test_filterProducts_updatesSelectedCategory() {
        let viewModel = ProductsViewModel(realm: InMemoryRealmHelper.makeRealm())

        viewModel.filterProducts(searchText: "", category: "electronics")

        XCTAssertEqual(viewModel.selectedCategory, "electronics")
    }

    func test_filterProducts_callsDelegate() {
        let realm = InMemoryRealmHelper.makeRealm()
        let viewModel = ProductsViewModel(realm: realm)
        let delegate = MockProductsDelegate()
        viewModel.delegate = delegate

        viewModel.filterProducts(searchText: "", category: nil)

        XCTAssertTrue(delegate.didFetchProductsCalled)
    }

    func test_filterProducts_doesNotMutateAllProducts() {
        let realm = makeRealm(with: [
            makeProduct(id: 1, title: "Apple"),
            makeProduct(id: 2, title: "Banana")
        ])
        let viewModel = ProductsViewModel(realm: realm)

        viewModel.filterProducts(searchText: "Apple", category: nil)

        XCTAssertEqual(viewModel.allProducts.count, 2)
        XCTAssertEqual(viewModel.products.count, 1)
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
