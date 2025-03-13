//
//  AuthenticationService.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation
import RxSwift

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> Single<(User, Token)>
    func logout() -> Completable
}

class AuthenticationService: AuthenticationServiceProtocol {
    // MARK: - Properties
    private let sessionManager: SessionManager

    init(sessionManager: SessionManager = .shared) {
        self.sessionManager = sessionManager
    }

    // MARK: - Functions

    func login(email: String, password: String) -> Single<(User, Token)> {
        return Single.create { [weak self] single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if email == "Test@test.com" && password == "123456" {
                    let user = User(
                        email: email
                    )

                    let token = Token(
                        accessToken: "mock-access-token"
                    )

                    self?.sessionManager.saveUser(user)
                    self?.sessionManager.saveToken(token)

                    single(.success((user, token)))
                } else {
                    single(.failure(AuthError.invalidCredentials))
                }
            }
            return Disposables.create()
        }
    }

    func logout() -> Completable {
        return Completable.create { [weak self] completable in
            self?.sessionManager.clearSession()
            completable(.completed)
            return Disposables.create()
        }
    }
}

// MARK: - AuthError
enum AuthError: LocalizedError {
    case invalidCredentials
    case networkError
    case unauthorized
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Geçersiz email veya şifre"
        case .networkError:
            return "Bağlantı hatası"
        case .unauthorized:
            return "Oturum süresi doldu"
        case .unknown:
            return "Bilinmeyen bir hata oluştu"
        }
    }
}
