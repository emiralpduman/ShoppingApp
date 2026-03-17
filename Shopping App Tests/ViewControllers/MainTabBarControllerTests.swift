import XCTest
@testable import Shopping_App

final class MainTabBarControllerTests: XCTestCase {
    private var sut: MainTabBarController!

    override func setUp() {
        super.setUp()
        sut = MainTabBarController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_viewDidLoad_setsTwoTabs() {
        XCTAssertEqual(sut.viewControllers?.count, 2)
    }

    func test_viewDidLoad_hidesBackButton() {
        XCTAssertTrue(sut.navigationItem.hidesBackButton)
    }

    func test_viewDidLoad_selectedIndexIsZero() {
        XCTAssertEqual(sut.selectedIndex, 0)
    }

    func test_viewDidLoad_hasCartBarButton() {
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Cart")
    }

    func test_cartBarButton_hasAccessibilityId() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.accessibilityIdentifier, "navBar.cartButton")
    }

    func test_tabBarItems_haveAccessibilityIds() {
        let ids = sut.viewControllers?.map { $0.tabBarItem.accessibilityIdentifier }
        XCTAssertEqual(ids, ["tabBar.products", "tabBar.profile"])
    }

    func test_firstTab_isProductsViewController() {
        XCTAssertTrue(sut.viewControllers?.first is ProductsViewController)
    }
}
