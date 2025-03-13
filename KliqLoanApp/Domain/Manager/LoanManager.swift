//
//  LoanManager.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

struct LoanManager {
    static let shared = LoanManager()
    private init() {}

    static func increaseInterestRate(loan: inout Loan, interestRate: Double = 0.5) {
        loan.interest_rate += interestRate
    }

    static func updateLoanStatus(loan: inout Loan, status: LoanStatus = .defaulted) {
        loan.status = status
    }

    static func decreaseDueIn(loan: inout Loan, dueIn: Int = 1) {
        loan.due_in -= dueIn
    }
}
