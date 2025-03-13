//
//  BaseViewModelTests.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class BaseViewModelTests: XCTestCase {
    // MARK: - Properties

    private var disposeBag = DisposeBag()
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        scheduler = nil
        super.tearDown()
    }

    // MARK: - Helpers

    func makeSUT() -> BaseViewModel {
        let sut = BaseViewModel()
        return sut
    }

    // MARK: - Tests

    func test_WhenStartLoadingCalled_ShouldSetIsLoadingToTrue() {
        // Given
        let sut = makeSUT()
        let observer = scheduler.createObserver(Bool.self)

        // When
        sut.isLoading
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.startLoading()

        // Then
        XCTAssertEqual(observer.events.last?.value.element, true)
    }

    func test_WhenStopLoadingCalled_ShouldSetIsLoadingToFalse() {
        // Given
        let sut = makeSUT()
        let observer = scheduler.createObserver(Bool.self)

        // When
        sut.isLoading
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.startLoading()
        sut.stopLoading()

        // Then
        XCTAssertEqual(observer.events.last?.value.element, false)
    }

    func test_WhenInitialized_ShouldHaveDefaultValues() {
        // Given
        let sut = makeSUT()
        let observer = scheduler.createObserver(Bool.self)

        // When
        sut.isLoading
            .bind(to: observer)
            .disposed(by: disposeBag)

        // Then
        XCTAssertEqual(observer.events.last?.value.element, false)
    }

    func test_WhenHandleErrorCalledWithAuthError_ShouldEmitAuthErrorDescription() {
        // Given
        let sut = makeSUT()
        let observer = scheduler.createObserver(String.self)
        let authError = AuthError.invalidCredentials

        // When
        sut.error
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.handleError(authError)

        // Then
        XCTAssertEqual(observer.events.last?.value.element, authError.localizedDescription)
    }


    func test_WhenHandleErrorCalledWithGeneralError_ShouldEmitDefaultErrorMessage() {
        // Given
        let sut = makeSUT()
        let observer = scheduler.createObserver(String.self)
        let generalError = NSError(domain: "test", code: -1)

        // When
        sut.error
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.handleError(generalError)

        // Then
        XCTAssertEqual(observer.events.last?.value.element, "Bilinmeyen bir hata oluştu")
    }
}
