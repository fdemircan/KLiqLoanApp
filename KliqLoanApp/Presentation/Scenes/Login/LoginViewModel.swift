//
//  LoginViewModel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation
import RxSwift
import RxRelay

protocol LoginViewModelProtocol {
    var email: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }

    func login()
}

final class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    // MARK: - Properties
    
    private let authService: AuthenticationServiceProtocol
    private let router: LoginRouterProtocol

    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    // MARK: - Initialization

    init(authService: AuthenticationServiceProtocol, router: LoginRouterProtocol) {
        self.authService = authService
        self.router = router
        super.init()
    }

    // MARK: - Functions
    
    func login() {
        startLoading()

        authService.login(email: email.value, password: password.value)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] _ in
                    self?.stopLoading()
                    self?.router.navigateToHome()
                },
                onFailure: { [weak self] error in
                    self?.stopLoading()
                    self?.handleError(error)
                }
            )
            .disposed(by: disposeBag)
    }
}
