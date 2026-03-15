import XCTest
@testable import Shopping_App

final class HalfSizePresentationControllerTests: XCTestCase {
    func test_frameOfPresentedView_returnsBottomStrip() {
        let presented = UIViewController()
        let presenting = UIViewController()
        let sut = HalfSizePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        sut.setValue(containerView, forKey: "containerView")

        let frame = sut.frameOfPresentedViewInContainerView
        XCTAssertEqual(frame.height, 150)
        XCTAssertEqual(frame.origin.y, 812 - 150)
        XCTAssertEqual(frame.width, 375)
    }

    func test_frameOfPresentedView_noContainer_returnsZero() {
        let presented = UIViewController()
        let presenting = UIViewController()
        let sut = HalfSizePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )

        let frame = sut.frameOfPresentedViewInContainerView
        XCTAssertEqual(frame, .zero)
    }
}
