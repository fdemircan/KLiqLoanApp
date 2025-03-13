//
//  LoginRouter.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

protocol LoginRouterProtocol {
    func navigateToHome()
}

final class LoginRouter: BaseRouter, LoginRouterProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigateToHome() {
        let router: HomeRouterProtocol = HomeRouter(navigationController: navigationController)
        let viewController = HomeFactory.makeHomeViewController(router: router)
        setRoot(viewController)
    }
}
