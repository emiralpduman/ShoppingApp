import XCTest
import RealmSwift
import Moya
import ShoppingAppAPI
@testable import Shopping_App

final class LaunchViewModelTests: XCTestCase {

    private var sut: LaunchViewModel!
    private var mockDelegate: MockLaunchDelegate!

    override func setUp() {
        super.setUp()
        sut = LaunchViewModel()
        mockDelegate = MockLaunchDelegate()
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        sut = nil
        mockDelegate = nil
        super.tearDown()
    }

    // MARK: - Helpers

    private func makeStubbedProvider(jsonData: Data) -> MoyaProvider<FakeStoreService> {
        let endpointClosure = { (target: FakeStoreService) -> Endpoint in
            Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, jsonData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        return MoyaProvider<FakeStoreService>(
            endpointClosure: endpointClosure,
            stubClosure: MoyaProvider.immediatelyStub
        )
    }

    private var sampleProductsJSON: Data {
        """
        [
            {
                "id": 1,
                "title": "Test Product",
                "price": 29.99,
                "description": "A test product",
                "category": "electronics",
                "image": "https://example.com/img.png",
                "rating": { "rate": 4.5, "count": 100 }
            },
            {
                "id": 2,
                "title": "Another Product",
                "price": 49.99,
                "description": "Another test product",
                "category": "jewelery",
                "image": "https://example.com/img2.png",
                "rating": { "rate": 3.8, "count": 50 }
            }
        ]
        """.data(using: .utf8)!
    }

    // MARK: - Delegate Assignment

    func test_delegate_isInitiallyNil() {
        let viewModel = LaunchViewModel()

        XCTAssertNil(viewModel.delegate)
    }

    func test_delegate_canBeAssigned() {
        XCTAssertNotNil(sut.delegate)
    }

    func test_delegate_isWeaklyHeld() {
        let viewModel = LaunchViewModel()

        autoreleasepool {
            let delegate = MockLaunchDelegate()
            viewModel.delegate = delegate
            XCTAssertNotNil(viewModel.delegate)
        }

        XCTAssertNil(viewModel.delegate)
    }

    // MARK: - fetchProducts Delegate Callbacks

    func test_fetchProducts_callsWillFetchProducts() {
        sut.fetchProducts()

        XCTAssertTrue(mockDelegate.willFetchProductsCalled)
    }

    // MARK: - Stubbed Network Tests

    func test_fetchProducts_success_callsDidFetchProducts() {
        let provider = makeStubbedProvider(jsonData: sampleProductsJSON)
        let viewModel = LaunchViewModel(provider: provider)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockLaunchDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "didFetchProducts called")
        delegate.didFetchHandler = { expectation.fulfill() }

        viewModel.fetchProducts()

        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(delegate.didFetchProductsCalled)
    }

    func test_fetchProducts_success_writesProductsToRealm() {
        let realm = InMemoryRealmHelper.makeRealm()
        let provider = makeStubbedProvider(jsonData: sampleProductsJSON)
        let viewModel = LaunchViewModel(provider: provider)
        viewModel.injectedRealm = realm
        let delegate = MockLaunchDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "products written to realm")
        delegate.didFetchHandler = { expectation.fulfill() }

        viewModel.fetchProducts()

        waitForExpectations(timeout: 1.0)
        let products = realm.objects(ProductEntity.self)
        XCTAssertEqual(products.count, 2)
        XCTAssertNotNil(realm.object(ofType: ProductEntity.self, forPrimaryKey: 1))
        XCTAssertNotNil(realm.object(ofType: ProductEntity.self, forPrimaryKey: 2))
    }

    func test_fetchProducts_success_skipsExistingProducts() {
        let realm = InMemoryRealmHelper.makeRealm()

        // Pre-populate realm with product id=1
        // swiftlint:disable:next force_try
        try! realm.write {
            let existing = ProductEntity()
            existing._id = 1
            existing.title = "Existing Product"
            existing.price = 9.99
            realm.add(existing)
        }

        let provider = makeStubbedProvider(jsonData: sampleProductsJSON)
        let viewModel = LaunchViewModel(provider: provider)
        viewModel.injectedRealm = realm
        let delegate = MockLaunchDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "fetch completes")
        delegate.didFetchHandler = { expectation.fulfill() }

        viewModel.fetchProducts()

        waitForExpectations(timeout: 1.0)
        let products = realm.objects(ProductEntity.self)
        XCTAssertEqual(products.count, 2)

        // Verify the existing product was NOT overwritten
        let existingProduct = realm.object(ofType: ProductEntity.self, forPrimaryKey: 1)
        XCTAssertEqual(existingProduct?.title, "Existing Product")
        XCTAssertEqual(existingProduct?.price, 9.99)
    }
}

// MARK: - Mock Delegate

private final class MockLaunchDelegate: LaunchViewModelDelegate {
    var didFetchProductsCalled = false
    var willFetchProductsCalled = false
    var lastError: Error?

    var didFetchHandler: (() -> Void)?
    var didErrorHandler: (() -> Void)?

    func didErrorOccur(_ error: Error) {
        lastError = error
        didErrorHandler?()
    }

    func didFetchProducts() {
        didFetchProductsCalled = true
        didFetchHandler?()
    }

    func willFetchProducts() {
        willFetchProductsCalled = true
    }
}
