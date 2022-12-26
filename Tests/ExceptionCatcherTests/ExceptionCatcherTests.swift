import XCTest
import ExceptionCatcher

final class ExceptionCatcherTests: XCTestCase {}

extension ExceptionCatcherTests {
    func testCatchingErrorOfRethrowMethod() {
        XCTAssertThrowsError(
            try ExceptionCatcher.rethrow(callback: throwsException)
        )
    }

    func testReturnValueOfRethrowMethod() {
        let expectedResult = "Result"
        let result = try? ExceptionCatcher.rethrow { expectedResult }
        XCTAssertEqual(result, expectedResult)
    }

    func testForwardingErrorOfRethrowMethod() {
        let expectation = XCTestExpectation(description: "Throw an error")
        do {
            try ExceptionCatcher.rethrow(callback: throwsError)
        } catch {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .zero)
    }
}

extension ExceptionCatcherTests {
    func testCatchingErrorOfResultMethod() {
        let successExpectation = XCTestExpectation(description: "success", isInverted: true)
        let failureExpectation = XCTestExpectation(description: "failure")

        let result = ExceptionCatcher.catch(callback: throwsException)
        switch result {
        case .success:
            successExpectation.fulfill()
        case .error, .exception:
            failureExpectation.fulfill()
        }
    }

    func testReturnValueOfResultMethod() {
        let successExpectation = XCTestExpectation(description: "success")
        let failureExpectation = XCTestExpectation(description: "failure", isInverted: true)

        let expectedResult = "Result"
        let result = ExceptionCatcher.catch { expectedResult }
        switch result {
        case let .success(success):
            successExpectation.fulfill()
            XCTAssertEqual(success, expectedResult)
        case .error, .exception:
            failureExpectation.fulfill()
        }
    }

    func testForwardingErrorOfResultMethod() {
        let successExpectation = XCTestExpectation(description: "success", isInverted: true)
        let exceptionExpectation = XCTestExpectation(description: "exception", isInverted: true)
        let errorExpectation = XCTestExpectation(description: "error")

        let result = ExceptionCatcher.catch(callback: throwsError)
        switch result {
        case .success:
            successExpectation.fulfill()
        case .exception:
            exceptionExpectation.fulfill()
        case let .error(error):
            errorExpectation.fulfill()
            XCTAssertEqual(TestError.error.localizedDescription, error.localizedDescription)
        }
    }
}

extension ExceptionCatcherTests {
    private func throwsException() {
        let foo = Foo()
        foo.value(forKey: "nonexistentKey")
    }

    private func throwsError() throws {
        throw TestError.error
    }
}
