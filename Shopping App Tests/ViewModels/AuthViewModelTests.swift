import XCTest
import RealmSwift
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

    // MARK: - signIn

    func test_signIn_success_callsDidSignInSuccessfully() {
        let mockAuth = MockAuthService()
        mockAuth.signInResult = ("uid-123", nil)
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signIn completes")
        // signIn calls didSignInSuccesfully twice for new users (inside realm.write + after if block)
        expectation.expectedFulfillmentCount = 2
        delegate.didSignInHandler = { expectation.fulfill() }

        viewModel.signIn(email: "test@test.com", password: "password")

        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(delegate.didSignInCalled)
    }

    func test_signIn_error_callsDidErrorOccur() {
        let mockAuth = MockAuthService()
        let testError = NSError(domain: "test", code: 1, userInfo: nil)
        mockAuth.signInResult = (nil, testError)
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signIn error")
        delegate.didErrorHandler = { expectation.fulfill() }

        viewModel.signIn(email: "test@test.com", password: "password")

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(delegate.lastError)
    }

    func test_signIn_newUser_createsUserInRealm() {
        let mockAuth = MockAuthService()
        mockAuth.signInResult = ("uid-new", nil)
        mockAuth.currentUserEmail = "new@test.com"
        let realm = InMemoryRealmHelper.makeRealm()
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = realm
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signIn creates user")
        // signIn calls didSignInSuccesfully twice for new users
        expectation.expectedFulfillmentCount = 2
        delegate.didSignInHandler = { expectation.fulfill() }

        viewModel.signIn(email: "new@test.com", password: "password")

        waitForExpectations(timeout: 1.0)
        let users = realm.objects(UserEntity.self)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?._id, "uid-new")
        XCTAssertEqual(users.first?.emailAddress, "new@test.com")
    }

    // MARK: - signUp

    func test_signUp_success_callsDidSignUpSuccessfully() {
        let mockAuth = MockAuthService()
        mockAuth.signUpResult = ("uid-456", nil)
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signUp completes")
        // signUp calls didSignUpSuccesfully twice (before guard + inside realm.write)
        expectation.expectedFulfillmentCount = 2
        delegate.didSignUpHandler = { expectation.fulfill() }

        viewModel.signUp(email: "signup@test.com", password: "password", userName: "NewUser")

        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(delegate.didSignUpCalled)
    }

    func test_signUp_error_callsDidErrorOccur() {
        let mockAuth = MockAuthService()
        let testError = NSError(domain: "test", code: 2, userInfo: nil)
        mockAuth.signUpResult = (nil, testError)
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signUp error")
        // signUp calls didErrorOccur twice (for error + for noUid since uid is nil)
        expectation.expectedFulfillmentCount = 2
        delegate.didErrorHandler = { expectation.fulfill() }

        viewModel.signUp(email: "signup@test.com", password: "password", userName: "NewUser")

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(delegate.lastError)
    }

    func test_signUp_noUid_callsDidErrorOccurWithNoUid() {
        let mockAuth = MockAuthService()
        mockAuth.signUpResult = (nil, nil)
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = InMemoryRealmHelper.makeRealm()
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signUp no uid error")
        delegate.didErrorHandler = { expectation.fulfill() }

        viewModel.signUp(email: "signup@test.com", password: "password", userName: "NewUser")

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(delegate.lastError)
        XCTAssertTrue(delegate.lastError is AuthViewModelError)
    }

    func test_signUp_success_createsUserInRealm() {
        let mockAuth = MockAuthService()
        mockAuth.signUpResult = ("uid-789", nil)
        let realm = InMemoryRealmHelper.makeRealm()
        let viewModel = AuthViewModel(authService: mockAuth)
        viewModel.injectedRealm = realm
        let delegate = MockAuthDelegate()
        viewModel.delegate = delegate

        let expectation = expectation(description: "signUp creates user")
        // signUp calls didSignUpSuccesfully twice (before guard + inside realm.write)
        expectation.expectedFulfillmentCount = 2
        delegate.didSignUpHandler = { expectation.fulfill() }

        viewModel.signUp(email: "new@test.com", password: "password", userName: "NewUser")

        waitForExpectations(timeout: 1.0)
        let users = realm.objects(UserEntity.self)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?._id, "uid-789")
        XCTAssertEqual(users.first?.userName, "NewUser")
        XCTAssertEqual(users.first?.emailAddress, "new@test.com")
    }
}

// MARK: - Mock Delegate

private final class MockAuthDelegate: AuthViewModelDelegate {
    var didSignUpCalled = false
    var didSignInCalled = false
    var willRequestServiceCalled = false
    var lastError: Error?

    var didSignInHandler: (() -> Void)?
    var didSignUpHandler: (() -> Void)?
    var didErrorHandler: (() -> Void)?

    func didErrorOccur(error: Error) {
        lastError = error
        didErrorHandler?()
    }

    func didSignUpSuccesfully() {
        didSignUpCalled = true
        didSignUpHandler?()
    }

    func didSignInSuccesfully() {
        didSignInCalled = true
        didSignInHandler?()
    }

    func willRequestService() {
        willRequestServiceCalled = true
    }
}
