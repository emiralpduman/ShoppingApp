//
//  LaunchViewTests.swift
//  Shopping App Tests
//

import XCTest
@testable import Shopping_App

final class LaunchViewTests: XCTestCase {
    private var sut: LaunchView!

    override func setUp() {
        super.setUp()
        sut = LaunchView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization

    func test_init_createsView() {
        XCTAssertNotNil(sut)
    }

    // MARK: - Accessibility Identifiers

    func test_accessibilityIdentifier_appIcon() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "launch.appIcon")
        XCTAssertNotNil(imageView)
    }

    func test_accessibilityIdentifier_activityIndicator() {
        XCTAssertEqual(sut.activityIndicatorView.accessibilityIdentifier, "launch.activityIndicator")
    }

    // MARK: - Subviews

    func test_activityIndicator_isAddedAsSubview() {
        XCTAssertTrue(sut.subviews.contains(sut.activityIndicatorView))
    }

    func test_appIcon_isAddedAsSubview() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "launch.appIcon")
        XCTAssertNotNil(imageView)
        XCTAssertTrue(sut.subviews.contains(imageView!))
    }

    // MARK: - Image View Properties

    func test_appIcon_contentModeIsAspectFit() {
        let imageView = findSubview(ofType: UIImageView.self, in: sut, identifier: "launch.appIcon")
        XCTAssertEqual(imageView?.contentMode, .scaleAspectFit)
    }

    // MARK: - Helpers

    private func findSubview<T: UIView>(ofType type: T.Type, in view: UIView, identifier: String) -> T? {
        if let match = view as? T, match.accessibilityIdentifier == identifier {
            return match
        }
        for subview in view.subviews {
            if let found = findSubview(ofType: type, in: subview, identifier: identifier) {
                return found
            }
        }
        return nil
    }
}
