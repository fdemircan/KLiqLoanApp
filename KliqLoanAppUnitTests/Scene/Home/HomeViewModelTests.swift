//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class HomeViewModelTests: XCTestCase {
    // MARK: - Properties

    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Helpers

    func makeSUT() -> HomeViewModel {
        let mockRepository = MockLoanRepository()
        let mockRouter = MockHomeRouter()
        let sut = HomeViewModel(
            repository: mockRepository,
            router: mockRouter
        )
        return sut
    }

    func makeSUT(repository: MockLoanRepository) -> HomeViewModel {
        let mockRouter = MockHomeRouter()
        let sut = HomeViewModel(
            repository: repository,
            router: mockRouter
        )
        return sut
    }

    func makeSUT(router: MockHomeRouter) -> HomeViewModel {
        let mockRepository = MockLoanRepository()
        let sut = HomeViewModel(
            repository: mockRepository,
            router: router
        )
        return sut
    }

    // MARK: - Fetch Loans Tests

    func test_fetchLoans_returnSuccess() {
        // Given
        let expect = expectation(description: #function)
        let expectedLoans = [
            Loan(name: "Personal Loan", principal_amount: 5000, interest_rate: 3.5, status: .active, due_in: 30),
            Loan(name: "Mortgage", principal_amount: 150000, interest_rate: 2.8, status: .active, due_in: 360)
        ]
        let mockRepository = MockLoanRepository()
        mockRepository.mockLoans = expectedLoans
        let sut = makeSUT(repository: mockRepository)
        var result: Int = 0

        //When
        sut.fetchLoans()

        sut.loans
            .skip(1)
            .take(1)
            .subscribe(onNext: { model in
                result = model.count
                expect.fulfill()
            })
            .disposed(by: disposeBag)

        //Then
        waitForExpectations(timeout: TestConstants.timeout) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertEqual(expectedLoans.count, result)
            XCTAssertEqual(sut.loans.value.count, expectedLoans.count)
        }
    }

    func test_fetchLoans_returnFailure() {
        // Given
        let expect = expectation(description: #function)
        let mockRepository = MockLoanRepository()
        mockRepository.mockError = "Bilinmeyen bir hata oluştu"
        let sut = makeSUT(repository: mockRepository)
        var receivedError: String?

        // When
        sut.fetchLoans()

        sut.error
            .skip(1)
            .take(1)
            .subscribe(onNext: { error in
                receivedError = error
                expect.fulfill()
            })
            .disposed(by: disposeBag)

        // Then
        waitForExpectations(timeout: TestConstants.timeout) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertEqual(receivedError, mockRepository.mockError)
            XCTAssertTrue(sut.loans.value.isEmpty)
        }
    }

    // MARK: - Navigation Tests

    func testLogout() {
        // Given
        let mockRouter = MockHomeRouter()
        let sut = makeSUT(router: mockRouter)

        // When
        sut.logout()

        // Then
        XCTAssertTrue(mockRouter.logoutCalled)
    }

}
