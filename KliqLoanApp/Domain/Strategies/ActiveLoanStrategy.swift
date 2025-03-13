//
//  ActiveLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class ActiveLoanStrategy: LoanStrategy {
    func applyLoanRules(loan: inout Loan) {
        LoanManager.decreaseDueIn(loan: &loan)
    }
}
