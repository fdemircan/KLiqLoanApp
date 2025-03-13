//
//  PasswordValidationProvider.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import Foundation

final class PasswordValidationProvider: ValidationProvider {
    typealias Value = String
    let minLength: Int

    init(minLength: Int = 6) {
        self.minLength = minLength
    }

    func validate(_ value: String?) -> ValidationResult {
        guard let value = value, !value.isEmpty, value.count >= minLength else {
            return .failure("Şifreniz en az 6 karakter olmalıdır.")
        }
        return .success
    }
}
