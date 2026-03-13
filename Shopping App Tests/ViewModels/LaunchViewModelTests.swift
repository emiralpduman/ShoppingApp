import XCTest
@testable import Shopping_App

final class LaunchViewModelTests: XCTestCase {

    private var sut: LaunchViewModel!
    private var mockDelegate: MockLaunchDelegate!

    override func setUp() {
        super.setUp()
        sut = LaunchViewModel()
        mockDelegate = MockLaunchDelegate()
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        sut = nil
        mockDelegate = nil
        super.tearDown()
    }

    // MARK: - Delegate Assignment

    func test_delegate_isInitiallyNil() {
        let viewModel = LaunchViewModel()

        XCTAssertNil(viewModel.delegate)
    }

    func test_delegate_canBeAssigned() {
        XCTAssertNotNil(sut.delegate)
    }

    func test_delegate_isWeaklyHeld() {
        let viewModel = LaunchViewModel()

        autoreleasepool {
            let delegate = MockLaunchDelegate()
            viewModel.delegate = delegate
            XCTAssertNotNil(viewModel.delegate)
        }

        XCTAssertNil(viewModel.delegate)
    }

    // MARK: - fetchProducts Delegate Callbacks

    func test_fetchProducts_callsWillFetchProducts() {
        // fetchProducts calls delegate?.willFetchProducts() synchronously
        // before the async network request
        sut.fetchProducts()

        XCTAssertTrue(mockDelegate.willFetchProductsCalled)
    }
}

// MARK: - Mock Delegate

private final class MockLaunchDelegate: LaunchViewModelDelegate {
    var didFetchProductsCalled = false
    var willFetchProductsCalled = false
    var lastError: Error?

    func didErrorOccur(_ error: Error) {
        lastError = error
    }

    func didFetchProducts() {
        didFetchProductsCalled = true
    }

    func willFetchProducts() {
        willFetchProductsCalled = true
    }
}
