import XCTest
import RealmSwift
@testable import Shopping_App

final class ProductsViewControllerTests: XCTestCase {
    private var realm: Realm!
    private var sut: ProductsViewController!

    override func setUp() {
        super.setUp()
        realm = InMemoryRealmHelper.makeRealm()
    }

    override func tearDown() {
        sut = nil
        realm = nil
        super.tearDown()
    }

    func test_viewDidLoad_setsTitle() {
        let viewModel = ProductsViewModel(realm: realm)
        sut = ProductsViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.title, "Products")
    }

    func test_numberOfItemsInSection_returnsProductCount() {
        let product = ProductEntity()
        product._id = 1
        product.title = "Test"
        // swiftlint:disable:next force_try
        try! realm.write { realm.add(product) }

        let viewModel = ProductsViewModel(realm: realm)
        sut = ProductsViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()

        let collectionView = (sut.view as? ProductsView)?.productsCollectionView
        let count = sut.collectionView(collectionView!, numberOfItemsInSection: 0)

        XCTAssertEqual(count, 1)
    }

    func test_numberOfItemsInSection_emptyRealm_returnsZero() {
        let viewModel = ProductsViewModel(realm: realm)
        sut = ProductsViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()

        let collectionView = (sut.view as? ProductsView)?.productsCollectionView
        let count = sut.collectionView(collectionView!, numberOfItemsInSection: 0)

        XCTAssertEqual(count, 0)
    }
}
