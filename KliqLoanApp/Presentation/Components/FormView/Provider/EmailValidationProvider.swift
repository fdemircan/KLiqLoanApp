//
//  EmailValidationProvider.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import Foundation

final class EmailValidationProvider: ValidationProvider {
    typealias Value = String

    func validate(_ value: String?) -> ValidationResult {
        guard let value = value else { return .failure("Input is nil") }
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: value) ? .success : .failure("Geçerli bir e-posta adresi giriniz.")
    }
}
