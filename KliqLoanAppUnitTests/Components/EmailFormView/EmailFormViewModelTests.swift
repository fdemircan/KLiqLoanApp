//
//  EmailFormViewModelTests.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class EmailFormViewModelTests: XCTestCase {
    // MARK: - Properties

    private var disposeBag = DisposeBag()
    private var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        scheduler = nil
        super.tearDown()
    }

    // MARK: - Helpers
    
    func makeSUT() -> EmailFormViewModel {
        let sut = EmailFormViewModel()
        return sut
    }

    // MARK: - Tests

    func test_WhenInitialized_ShouldHaveEmptyInitialValue() {
        //Given
        let sut = makeSUT()

        // When

        //Then
        XCTAssertEqual(sut.selectedValue.value, "")
    }

    func test_WhenInitializedWithValue_ShouldHaveCorrectValue() {
        //Given
        let sut = makeSUT()
        let initialValue = "test@example.com"

        //When
        sut.selectedValue.accept(initialValue)

        //Then
        XCTAssertEqual(sut.selectedValue.value, initialValue)
    }

    func test_WhenValidEmailEntered_ShouldReturnSuccess() {
        // Given
        let sut = makeSUT()
        let validEmail = "test@example.com"
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(validEmail)

        // Then
        if case .success = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return success for valid email")
        }
    }

    func test_WhenInvalidEmailEntered_ShouldReturnError() {
        // Given
        let sut = makeSUT()
        let invalidEmail = "invalid-email"
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(invalidEmail)

        // Then
        if case .failure = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return error for invalid email")
        }
    }

    func test_WhenEmailUpdated_ShouldEmitNewValue() {
        // Given
        let sut = makeSUT()
        let newEmail = "new@example.com"
        let observer = scheduler.createObserver(String.self)

        // When
        sut.selectedValue
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(newEmail)

        // Then
        XCTAssertEqual(observer.events.last?.value.element, newEmail)
    }

}
