import XCTest
@testable import Shopping_App

final class AddToCartViewControllerTests: XCTestCase {
    private var sut: AddToCartViewController!

    override func setUp() {
        super.setUp()
        sut = AddToCartViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_viewDidLoad_setsTitle() {
        XCTAssertEqual(sut.title, "Add to Cart")
    }

    func test_viewDidLoad_setsBackgroundColor() {
        XCTAssertEqual(sut.view.backgroundColor, .white)
    }

    func test_presentationDelegate_didSwipeDown_forwardsCall() {
        let mockDelegate = MockPresentationDelegate()
        sut.presentationDelegate = mockDelegate

        sut.didSwipeDown()

        XCTAssertTrue(mockDelegate.didSwipeDownCalled)
    }

    func test_presentationDelegate_didTapAddToCart_forwardsQuantity() {
        let mockDelegate = MockPresentationDelegate()
        sut.presentationDelegate = mockDelegate
        let view = AddToCartView(frame: .zero)
        view.quantity = 3

        sut.addToCartView(view, didTapAddButton: UIButton())

        XCTAssertEqual(mockDelegate.addedQuantity, 0)
    }

    func test_didTapQuantityStepper_updatesViewQuantity() {
        let view = AddToCartView(frame: .zero)
        let stepper = UIStepper()
        stepper.value = 5

        sut.addToCartView(view, didTapQuantityStepper: stepper)

        XCTAssertEqual(view.quantity, 5)
    }
}

private class MockPresentationDelegate: PresentationDelegate {
    var didSwipeDownCalled = false
    var addedQuantity: Int = 0

    func didSwipeDown() {
        didSwipeDownCalled = true
    }

    func didTapAddToCart(quantity: Int) {
        addedQuantity = quantity
    }
}
