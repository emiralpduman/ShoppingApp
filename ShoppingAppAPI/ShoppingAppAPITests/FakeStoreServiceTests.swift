import XCTest
import Moya
@testable import ShoppingAppAPI

final class FakeStoreServiceTests: XCTestCase {

    func test_baseURL() {
        let service = FakeStoreService.getProducts
        XCTAssertEqual(service.baseURL.absoluteString, "https://fakestoreapi.com")
    }

    func test_path() {
        let service = FakeStoreService.getProducts
        XCTAssertEqual(service.path, "/products")
    }

    func test_method() {
        let service = FakeStoreService.getProducts
        XCTAssertEqual(service.method, .get)
    }

    func test_task() {
        let service = FakeStoreService.getProducts
        switch service.task {
        case .requestPlain:
            break // Expected
        default:
            XCTFail("Expected .requestPlain but got \(service.task)")
        }
    }

    func test_headers() {
        let service = FakeStoreService.getProducts
        XCTAssertNil(service.headers)
    }
}
