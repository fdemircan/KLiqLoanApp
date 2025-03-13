//
//  MockHomeRouter.swift
//  KliqLoanAppTests
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit
@testable import KliqLoanApp

final class MockHomeRouter: HomeRouterProtocol {
    let navigationController: UINavigationController
    var logoutCalled = false

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func logout() {
        logoutCalled = true
    }
} 
