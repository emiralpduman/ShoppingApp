import XCTest
@testable import Shopping_App

final class AuthViewModelTests: XCTestCase {

    // MARK: - AuthViewModelError Descriptions

    func test_errorDescription_noUid() {
        let error = AuthViewModelError.noUid

        XCTAssertEqual(
            error.description,
            "UID of new user could not be retreived from authentication server."
        )
    }

    func test_errorDescription_cannotWriteToDb() {
        let error = AuthViewModelError.cannotWriteToDb

        XCTAssertEqual(
            error.description,
            "New user could not be written to local database."
        )
    }

    // MARK: - Error Conformance

    func test_authViewModelError_conformsToError() {
        let error: Error = AuthViewModelError.noUid

        XCTAssertNotNil(error)
    }

    func test_authViewModelError_casesAreDistinct() {
        XCTAssertNotEqual(
            AuthViewModelError.noUid.description,
            AuthViewModelError.cannotWriteToDb.description
        )
    }

    // MARK: - Delegate Assignment

    func test_delegate_isInitiallyNil() {
        let viewModel = AuthViewModel()

        XCTAssertNil(viewModel.delegate)
    }

    func test_delegate_isWeaklyHeld() {
        let viewModel = AuthViewModel()

        autoreleasepool {
            let delegate = MockAuthDelegate()
            viewModel.delegate = delegate
            XCTAssertNotNil(viewModel.delegate)
        }

        XCTAssertNil(viewModel.delegate)
    }
}

// MARK: - Mock Delegate

private final class MockAuthDelegate: AuthViewModelDelegate {
    var didSignUpCalled = false
    var didSignInCalled = false
    var willRequestServiceCalled = false
    var lastError: Error?

    func didErrorOccur(error: Error) {
        lastError = error
    }

    func didSignUpSuccesfully() {
        didSignUpCalled = true
    }

    func didSignInSuccesfully() {
        didSignInCalled = true
    }

    func willRequestService() {
        willRequestServiceCalled = true
    }
}
