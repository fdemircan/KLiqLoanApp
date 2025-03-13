//
//  PasswordFormViewModel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation
import RxSwift
import RxRelay

final class PasswordFormViewModel: FormViewModel {
    // MARK: - Properties
    private let validator: PasswordValidationProvider

    // MARK: - Initialization
    init(minLength: Int = 6) {
        self.validator = PasswordValidationProvider(minLength: minLength)
        super.init()
    }

    // MARK: - Validation
    override var validationResult: Observable<ValidationResult> {
        return selectedValue.map { [weak self] value in
            guard let self = self else { return .success }
            return self.validator.validate(value)
        }
    }
}
