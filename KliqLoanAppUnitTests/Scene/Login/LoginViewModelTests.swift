//
//  LoginViewModelTests.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import XCTest
import RxSwift
import RxTest
@testable import KliqLoanApp

final class LoginViewModelTests: XCTestCase {
    // MARK: - Properties

    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Helpers

    func makeSUT() -> LoginViewModel {
        let authService = MockAuthService()
        let router = MockLoginRouter()
        let sut = LoginViewModel(
            authService: authService,
            router: router
        )
        return sut
    }

    func makeSUT(service: MockAuthService) -> LoginViewModel {
        let router = MockLoginRouter()
        let sut = LoginViewModel(
            authService: service,
            router: router
        )
        return sut
    }

    func makeSUT(router: MockLoginRouter) -> LoginViewModel {
        let authService = MockAuthService()
        let sut = LoginViewModel(
            authService: authService,
            router: router
        )
        return sut
    }

    func makeSUT(router: MockLoginRouter, service: MockAuthService) -> LoginViewModel {
        let sut = LoginViewModel(
            authService: service,
            router: router
        )
        return sut
    }

    // MARK: - Tests

    func test_WhenEmailAndPasswordAreValid_LoginShouldBeCalled() {
        // Given
        let authService = MockAuthService()
        let sut = makeSUT(service: authService)

        let expectedEmail = "Test@test.com"
        let expectedPassword = "123456"

        sut.email.accept(expectedEmail)
        sut.password.accept(expectedPassword)

        // When
        sut.login()

        // Then
        XCTAssertEqual(authService.loginCallCount, 1)
        XCTAssertEqual(authService.lastEmail, expectedEmail)
        XCTAssertEqual(authService.lastPassword, expectedPassword)
    }

    func test_WhenLoginIsSuccessful_ShouldNavigateToHome() {
        // Given
        let router = MockLoginRouter()
        let authService = MockAuthService()
        let sut = makeSUT(router: router, service: authService)

        let mockUser = User(email: "Test@test.com")
        let mockToken = Token(accessToken: "mock_access_token")
       
        sut.email.accept("Test@test.com")
        sut.password.accept("123456")
        authService.mockLoginResult = .success((mockUser, mockToken))

        // When
        sut.login()

        // Then
        XCTAssertEqual(router.navigateToHomeCallCount, 1)
    }

    func test_WhenLoginFails_ShouldNotNavigateToHome() {
        // Given
        let router = MockLoginRouter()
        let authService = MockAuthService()
        let sut = makeSUT(router: router, service: authService)

        sut.email.accept("test@test.com")
        sut.password.accept("123456")
        authService.mockLoginResult = .failure(NSError(domain: "auth", code: -1))

        // When
        sut.login()

        // Then
        XCTAssertEqual(router.navigateToHomeCallCount, 0)
    }

}
