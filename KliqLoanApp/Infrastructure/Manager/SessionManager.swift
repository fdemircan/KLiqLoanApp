//
//  SessionManager.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation

final class SessionManager {
    // MARK: - Singleton
    static let shared = SessionManager()

    private init() {
        loadUser()
        loadToken()
    }

    // MARK: - Constants
    private enum Constants {
        static let userKey = "com.kliq.user"
        static let tokenKey = "com.kliq.token"
    }

    // MARK: - Properties

    private let defaults = UserDefaults.standard
    private(set) var currentUser: User?
    private(set) var currentToken: Token?

    var isLoggedIn: Bool {
        return currentUser != nil && currentToken != nil
    }

    // MARK: - Functions

    private func loadUser() {
        guard let userData = defaults.data(forKey: Constants.userKey),
              let user = try? JSONDecoder().decode(User.self, from: userData) else {
            return
        }
        currentUser = user
    }

    private func loadToken() {
        guard let tokenData = defaults.data(forKey: Constants.tokenKey),
              let token = try? JSONDecoder().decode(Token.self, from: tokenData) else {
            return
        }
        currentToken = token
    }

    func saveToken(_ token: Token) {
        do {
            let tokenData = try JSONEncoder().encode(token)
            defaults.set(tokenData, forKey: Constants.tokenKey)
            currentToken = token
        } catch {
            print("Token kaydedilirken hata oluştu: \(error.localizedDescription)")
        }
    }

    func saveUser(_ user: User) {
        do {
            let userData = try JSONEncoder().encode(user)
            defaults.set(userData, forKey: Constants.userKey)
            currentUser = user
        } catch {
            print("Kullanıcı kaydedilirken hata oluştu: \(error.localizedDescription)")
        }
    }

    func clearSession() {
        currentUser = nil
        currentToken = nil
        defaults.removeObject(forKey: Constants.userKey)
        defaults.removeObject(forKey: Constants.tokenKey)
    }

}
