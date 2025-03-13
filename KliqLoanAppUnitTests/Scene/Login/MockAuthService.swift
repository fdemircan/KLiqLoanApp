//
//  MockAuthService.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import Foundation
import UIKit
import RxSwift
@testable import KliqLoanApp

final class MockAuthService: AuthenticationServiceProtocol {
    var loginCallCount = 0
    var logoutCallCount = 0
    var lastEmail: String?
    var lastPassword: String?
    var mockLoginResult: Result<(User, Token), Error>

    init(mockLoginResult: Result<(User, Token), Error> = .success(MockAuthService.defaultUserToken)) {
        self.mockLoginResult = mockLoginResult
    }

    func login(email: String, password: String) -> Single<(User, Token)> {
        loginCallCount += 1
        lastEmail = email
        lastPassword = password

        switch mockLoginResult {
        case .success:
            let mockUser = User(email: email)
            let mockToken = Token(accessToken: "mock_access_token")
            return .just((mockUser, mockToken))
        case .failure(let error):
            return .error(error)
        }
    }

    func logout() -> Completable {
        logoutCallCount += 1
        return .empty()
    }
}

// MARK: - MockAuthenticationService + Default Values

private extension MockAuthService {
    static var defaultUserToken: (User, Token) {
        (
            User(email: "Test@test.com"),
            Token(accessToken: "mock_access_token")
        )
    }
}
