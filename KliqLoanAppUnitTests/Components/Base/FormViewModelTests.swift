//
//  FormViewModelTests.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class FormViewModelTests: XCTestCase {
    // MARK: - Properties

    private var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Helpers

    func makeSUT() -> PasswordFormViewModel {
        let sut = PasswordFormViewModel()
        return sut
    }

    // MARK: - Tests

    func test_validateEmpty_whenValueIsNil_shouldReturnFailure() {
        // Given
        let sut = makeSUT()
        let value: String? = nil

        // When
        let result = sut.validateEmpty(value)

        // Then
        switch result {
        case .failure(let message):
            XCTAssertEqual(message, "Bu alan boş bırakılamaz")
        case .success:
            XCTFail("Başarısız olması bekleniyordu")
        }
    }

    func test_validateEmpty_whenValueIsEmpty_shouldReturnFailure() {
        // Given
        let sut = makeSUT()
        let value: String? = ""

        // When
        let result = sut.validateEmpty(value)

        // Then
        switch result {
        case .failure(let message):
            XCTAssertEqual(message, "Bu alan boş bırakılamaz")
        case .success:
            XCTFail("Başarısız olması bekleniyordu")
        }
    }

    func test_validateEmpty_whenValueIsValid_shouldReturnSuccess() {
        // Given
        let sut = makeSUT()
        let value: String? = "Test"

        // When
        let result = sut.validateEmpty(value)

        // Then
        switch result {
        case .success:
            // Test başarılı
            break
        case .failure:
            XCTFail("Başarılı olması bekleniyordu")
        }
    }

    func test_selectedValue_whenInitialized_shouldBeEmpty() {
        // Given
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "selectedValue başlangıç değeri kontrolü")
        var receivedValue: String?

        // When
        sut.selectedValue
            .subscribe(onNext: { value in
                receivedValue = value
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValue, "")
    }

    func test_selectedValue_whenUpdated_shouldEmitNewValue() {
        // Given
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "selectedValue güncelleme kontrolü")
        let testValue = "Test Value"
        var receivedValue: String?

        // When
        sut.selectedValue
            .subscribe(onNext: { value in
                receivedValue = value
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        sut.selectedValue.accept(testValue)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValue, testValue)
    }
}
