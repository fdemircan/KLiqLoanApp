//
//  Router.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

enum PresentationStyle {
    case push
    case present(fullScreen: Bool = true)
    case setRoot
}

protocol BaseRouter {
    var navigationController: UINavigationController { get }
}

extension BaseRouter {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func present(_ viewController: UIViewController, fullScreen: Bool = true, animated: Bool = true) {
        if fullScreen {
            viewController.modalPresentationStyle = .fullScreen
        }
        navigationController.present(viewController, animated: animated)
    }

    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}
