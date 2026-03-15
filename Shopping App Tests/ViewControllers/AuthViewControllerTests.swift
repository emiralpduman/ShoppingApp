import XCTest
@testable import Shopping_App

final class AuthViewControllerTests: XCTestCase {
    // MARK: - AuthViewControllerError Tests

    func test_emptyInputFields_description() {
        let error = AuthViewControllerError.emptyInputFields
        XCTAssertEqual(error.description, "Please fill all fields.")
    }

    func test_passwordsNoMatch_description() {
        let error = AuthViewControllerError.passwordsNoMatch
        XCTAssertEqual(error.description, "Passwords do not match.")
    }

    func test_emptyInputFields_isError() {
        let error: Error = AuthViewControllerError.emptyInputFields
        XCTAssertNotNil(error)
    }

    func test_passwordsNoMatch_isError() {
        let error: Error = AuthViewControllerError.passwordsNoMatch
        XCTAssertNotNil(error)
    }

    // MARK: - UIAlertController Extension Tests

    func test_standardizeForAuth_addsOneAction() {
        let alert = UIAlertController(title: "Test", message: "Test", preferredStyle: .alert)
        alert.standardizeForAuth()
        XCTAssertEqual(alert.actions.count, 1)
    }

    func test_standardizeForAuth_actionTitleIsOK() {
        let alert = UIAlertController(title: "Test", message: "Test", preferredStyle: .alert)
        alert.standardizeForAuth()
        XCTAssertEqual(alert.actions.first?.title, "OK")
    }

    func test_standardizeForAuth_actionStyleIsDefault() {
        let alert = UIAlertController(title: "Test", message: "Test", preferredStyle: .alert)
        alert.standardizeForAuth()
        XCTAssertEqual(alert.actions.first?.style, .default)
    }

    // MARK: - ViewController Tests

    func test_viewDidLoad_setsTitle() {
        let sut = AuthViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Sign-In")
    }

    func test_viewDidLoad_hidesBackButton() {
        let sut = AuthViewController()
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.navigationItem.hidesBackButton)
    }

    func test_didValueChange_updatesTitle() {
        let sut = AuthViewController()
        sut.loadViewIfNeeded()

        let segmentControl = UISegmentedControl(items: ["Sign-In", "Sign-Up"])
        segmentControl.selectedSegmentIndex = 1

        sut.didValueChange(segmentControl)

        XCTAssertEqual(sut.title, "Sign-Up")
    }
}
