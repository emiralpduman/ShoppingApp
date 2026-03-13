import XCTest
@testable import ShoppingAppAPI

final class ProductAPIModelTests: XCTestCase {

    private let completeJSON = """
    {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description": "Your perfect pack for everyday use.",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {
            "rate": 3.9,
            "count": 120
        }
    }
    """

    func test_decodeCompleteProduct() throws {
        let data = Data(completeJSON.utf8)
        let product = try JSONDecoder().decode(Product.self, from: data)

        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.title, "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops")
        XCTAssertEqual(product.price, 109.95)
        XCTAssertEqual(product.description, "Your perfect pack for everyday use.")
        XCTAssertEqual(product.category, "men's clothing")
        XCTAssertNotNil(product.image)
        XCTAssertNotNil(product.rating)
    }

    func test_decodePartialProduct() throws {
        let data = Data("""
        {"id": 99, "title": "Partial"}
        """.utf8)

        let product = try JSONDecoder().decode(Product.self, from: data)
        XCTAssertEqual(product.id, 99)
        XCTAssertEqual(product.title, "Partial")
        XCTAssertNil(product.price)
        XCTAssertNil(product.description)
        XCTAssertNil(product.category)
        XCTAssertNil(product.image)
        XCTAssertNil(product.rating)
    }

    func test_ratingDecode() throws {
        let data = Data("""
        {"rate": 4.1, "count": 259}
        """.utf8)

        let rating = try JSONDecoder().decode(Rating.self, from: data)
        XCTAssertEqual(rating.rate, 4.1)
        XCTAssertEqual(rating.count, 259)
    }
}
