//
//  EmailFormView.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 10.03.2025.
//

import Foundation
import RxSwift
import RxRelay

final class EmailFormViewModel: FormViewModel {
    // MARK: - Properties
    private let validator: EmailValidationProvider

    // MARK: - Initialization
    override init() {
        self.validator = EmailValidationProvider()
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
