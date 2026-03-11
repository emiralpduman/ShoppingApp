import XCTest
import RealmSwift
@testable import Shopping_App

final class ProductEntityTests: XCTestCase {

    private var realm: Realm!

    override func setUp() {
        super.setUp()
        realm = InMemoryRealmHelper.makeRealm()
    }

    override func tearDown() {
        realm = nil
        super.tearDown()
    }

    func test_defaultValues() {
        let product = ProductEntity()
        XCTAssertEqual(product._id, 0)
        XCTAssertEqual(product.title, "")
        XCTAssertEqual(product.price, 0.0)
        XCTAssertEqual(product.desc, "")
        XCTAssertEqual(product.category, "")
        XCTAssertEqual(product.image, "")
        XCTAssertNil(product.rating)
    }

    func test_primaryKey() {
        let schema = ProductEntity().objectSchema
        XCTAssertEqual(schema.primaryKeyProperty?.name, "_id")
    }

    func test_persistAndFetch() {
        let product = ProductEntity()
        product._id = 42
        product.title = "Test Product"
        product.price = 19.99
        product.desc = "A test description"
        product.category = "electronics"
        product.image = "https://example.com/image.png"

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(product)
        }

        let fetched = realm.object(ofType: ProductEntity.self, forPrimaryKey: 42)
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?._id, 42)
        XCTAssertEqual(fetched?.title, "Test Product")
        XCTAssertEqual(fetched?.price, 19.99)
        XCTAssertEqual(fetched?.desc, "A test description")
        XCTAssertEqual(fetched?.category, "electronics")
        XCTAssertEqual(fetched?.image, "https://example.com/image.png")
    }

    func test_ratingRelationship() {
        let rating = RatingEntity()
        rating.rate = 4.5
        rating.count = 200

        let product = ProductEntity()
        product._id = 10
        product.title = "Rated Product"
        product.rating = rating

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(product)
        }

        let fetched = realm.object(ofType: ProductEntity.self, forPrimaryKey: 10)
        XCTAssertNotNil(fetched?.rating)
        XCTAssertEqual(fetched?.rating?.rate, 4.5)
        XCTAssertEqual(fetched?.rating?.count, 200)
    }

    func test_updateExisting() {
        let product = ProductEntity()
        product._id = 5
        product.title = "Original"
        product.price = 10.0

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(product)
        }

        let updated = ProductEntity()
        updated._id = 5
        updated.title = "Updated"
        updated.price = 20.0

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(updated, update: .modified)
        }

        let allProducts = realm.objects(ProductEntity.self)
        XCTAssertEqual(allProducts.count, 1)

        let fetched = realm.object(ofType: ProductEntity.self, forPrimaryKey: 5)
        XCTAssertEqual(fetched?.title, "Updated")
        XCTAssertEqual(fetched?.price, 20.0)
    }
}
