//
//  OverdueLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class OverdueLoanStrategy: LoanStrategy {
    func applyLoanRules(loan: inout Loan) {
        if loan.due_in > 0 {
            LoanManager.increaseInterestRate(loan: &loan)
        }

        if loan.principal_amount > 5000 {
            LoanManager.updateLoanStatus(loan: &loan, status: .defaulted)
        }

        LoanManager.decreaseDueIn(loan: &loan, dueIn: 1)

        if loan.due_in < 0 {
            LoanManager.updateLoanStatus(loan: &loan, status: loan.principal_amount > 0 ? .overdue : .defaulted)
        }
    }
}
