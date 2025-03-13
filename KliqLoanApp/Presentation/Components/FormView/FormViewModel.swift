//
//  FormViewModel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol FormViewModelProtocol {
    var selectedValue: BehaviorRelay<String> { get set }
    var validationResult: Observable<ValidationResult> { get }
}

class FormViewModel: BaseViewModel, FormViewModelProtocol {
    // MARK: - Properties

    var selectedValue: BehaviorRelay<String>
    var validationResult: Observable<ValidationResult> {
        fatalError("Bu bir soyut sınıftır. Alt sınıfta validationResult'ı override edin.")
    }

    override init() {
        self.selectedValue = BehaviorRelay(value: "")
        super.init()
    }

    // MARK: - Protected Methods

    func validateEmpty(_ value: String?) -> ValidationResult {
        guard let value = value, !value.isEmpty else {
            return .failure("Bu alan boş bırakılamaz")
        }
        return .success
    }
}
