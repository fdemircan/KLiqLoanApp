//
//  AppDelegate.swift
//  KliqLoanApp
//
//  Created by Yusuf Çınar on 2.02.2025.
//

import UIKit

// MARK: - AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private var navigationController: UINavigationController?

    // MARK: - Application Lifecycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        setupWindow()
        setupInitialScreen()
        return true
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func setupInitialScreen() {
        guard let navigationController = navigationController else { return }

        if SessionManager.shared.isLoggedIn {
            showHomeScreen(navigationController: navigationController)
        } else {
            showLoginScreen(navigationController: navigationController)
        }
    }

    private func showLoginScreen(navigationController: UINavigationController) {
        let router = LoginRouter(navigationController: navigationController)
        let viewController = LoginFactory.makeLoginViewController(router: router)
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func showHomeScreen(navigationController: UINavigationController) {
        let router: HomeRouterProtocol = HomeRouter(navigationController: navigationController)
        let viewController = HomeFactory.makeHomeViewController(router: router)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
