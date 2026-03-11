import XCTest
@testable import Shopping_App

final class ProductDecodableTests: XCTestCase {

    func test_decodeFullProduct() throws {
        let json = """
        {
            "id": 1,
            "title": "Fjallraven Backpack",
            "price": 109.95,
            "description": "Your perfect pack",
            "category": "men's clothing",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating": {
                "rate": 3.9,
                "count": 120
            }
        }
        """.data(using: .utf8)!

        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.title, "Fjallraven Backpack")
        XCTAssertEqual(product.price, 109.95)
        XCTAssertEqual(product.description, "Your perfect pack")
        XCTAssertEqual(product.category, "men's clothing")
        XCTAssertNotNil(product.image)
        XCTAssertNotNil(product.rating)
    }

    func test_decodeProductArray() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "products", withExtension: "json") else {
            XCTFail("products.json not found in test bundle")
            return
        }
        let data = try Data(contentsOf: url)
        let products = try JSONDecoder().decode([Product].self, from: data)

        XCTAssertEqual(products.count, 2)
        XCTAssertEqual(products[0].id, 1)
        XCTAssertEqual(products[1].id, 2)
        XCTAssertEqual(products[0].price, 109.95)
        XCTAssertEqual(products[1].price, 22.3)
    }

    func test_decodeMissingFields() throws {
        let json = """
        {"id": 1}
        """.data(using: .utf8)!

        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertEqual(product.id, 1)
        XCTAssertNil(product.title)
        XCTAssertNil(product.price)
        XCTAssertNil(product.description)
        XCTAssertNil(product.category)
        XCTAssertNil(product.image)
        XCTAssertNil(product.rating)
    }

    func test_decodeEmptyObject() throws {
        let json = """
        {}
        """.data(using: .utf8)!

        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertNil(product.id)
        XCTAssertNil(product.title)
        XCTAssertNil(product.price)
        XCTAssertNil(product.description)
        XCTAssertNil(product.category)
        XCTAssertNil(product.image)
        XCTAssertNil(product.rating)
    }

    func test_decodeNestedRating() throws {
        let json = """
        {
            "id": 5,
            "rating": {
                "rate": 4.7,
                "count": 500
            }
        }
        """.data(using: .utf8)!

        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertNotNil(product.rating)
        XCTAssertEqual(product.rating?.rate, 4.7)
        XCTAssertEqual(product.rating?.count, 500)
    }
}
