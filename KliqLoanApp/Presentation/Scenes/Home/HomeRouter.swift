//
//  HomeRouter.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

protocol HomeRouterProtocol: BaseRouter {
    func logout()
}

final class HomeRouter: HomeRouterProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func logout() {
        let router = LoginRouter(navigationController: navigationController)
        let viewController = LoginFactory.makeLoginViewController(router: router)
        setRoot(viewController)
    }
}
