//
//  PasswordFormViewModelTests.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class PasswordFormViewModelTests: XCTestCase {
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

    func makeSUT() -> PasswordFormViewModel {
        let sut = PasswordFormViewModel()
        return sut
    }

    func makeSUT(minLength: Int) -> PasswordFormViewModel {
        let sut = PasswordFormViewModel(minLength: minLength)
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
        let initialValue = "123456"

        //When
        sut.selectedValue.accept(initialValue)

        //Then
        XCTAssertEqual(sut.selectedValue.value, initialValue)
    }

    func test_WhenValidPasswordEntered_ShouldReturnSuccess() {
        // Given
        let sut = makeSUT()
        let validPassword = "123456"
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(validPassword)

        // Then
        if case .success = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return success for valid password")
        }
    }

    func test_WhenShortPasswordEntered_ShouldReturnError() {
        // Given
        let sut = makeSUT()
        let shortPassword = "12345" // 6 karakterden kısa
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(shortPassword)

        // Then
        if case .failure = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return error for short password")
        }
    }

    func test_WhenEmptyPasswordEntered_ShouldReturnError() {
        // Given
        let sut = makeSUT()
        let emptyPassword = ""
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(emptyPassword)

        // Then
        if case .failure = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return error for empty password")
        }
    }

    func test_WhenCustomMinLengthSet_AndPasswordTooShort_ShouldReturnError() {
        // Given
        let customMinLength = 8
        let sut = makeSUT(minLength: customMinLength)
        let shortPassword = "1234567" // 8 karakterden kısa
        let observer = scheduler.createObserver(ValidationResult.self)

        // When
        sut.validationResult
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(shortPassword)

        // Then
        if case .failure = observer.events.last?.value.element {
            XCTAssertTrue(true)
        } else {
            XCTFail("Should return error for password shorter than custom minimum length")
        }
    }

    func test_WhenPasswordUpdated_ShouldEmitNewValue() {
        // Given
        let sut = makeSUT()
        let newPassword = "newpassword123"
        let observer = scheduler.createObserver(String.self)

        // When
        sut.selectedValue
            .bind(to: observer)
            .disposed(by: disposeBag)

        sut.selectedValue.accept(newPassword)

        // Then
        XCTAssertEqual(observer.events.last?.value.element, newPassword)
    }
}
