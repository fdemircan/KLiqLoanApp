//
//  ValidationProvider.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import Foundation

protocol ValidationProvider {
    associatedtype Value

    func validate(_ value: Value?) -> ValidationResult
}

enum ValidationResult {
    case success
    case failure(String)

    var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    var errorMessage: String? {
        switch self {
        case .success:
            return nil
        case .failure(let message):
            return message
        }
    }
}
