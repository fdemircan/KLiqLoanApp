//
//  Factories.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

// MARK: - Login Factory
final class LoginFactory {
    static func makeLoginViewController(router: LoginRouterProtocol) -> LoginViewController {
        let authService = AuthenticationService()
        let viewModel = LoginViewModel(authService: authService, router: router)
        return LoginViewController(viewModel: viewModel)
    }
}

// MARK: - Home Factory
final class HomeFactory {
    static func makeHomeViewController(router: HomeRouterProtocol) -> HomeViewController {
        let repository = LoanRepository(service: MockLoanService())
        let viewModel = HomeViewModel(repository: repository, router: router)
        return HomeViewController(viewModel: viewModel)
    }
}
