//
//  DefaultLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class DefaultLoanStrategy: LoanStrategy {
    func applyLoanRules(loan: inout Loan) {
        if loan.principal_amount < 1000 {
            LoanManager.updateLoanStatus(loan: &loan, status: .active)
        }

        LoanManager.decreaseDueIn(loan: &loan, dueIn: 1)

        if loan.due_in < 0 {
            LoanManager.updateLoanStatus(loan: &loan, status: loan.principal_amount > 0 ? .overdue : .defaulted)
        }
    }
}
