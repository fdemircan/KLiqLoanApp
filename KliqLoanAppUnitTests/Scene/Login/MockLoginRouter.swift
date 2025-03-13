//
//  MockLoginRouter.swift
//  KliqLoanAppUnitTests
//
//  Created by Demircan, Fetiye on 13.03.2025.
//

import UIKit
@testable import KliqLoanApp

final class MockLoginRouter: LoginRouterProtocol {
    var navigateToHomeCallCount = 0

    func navigateToHome() {
        navigateToHomeCallCount += 1
    }
}
