//
//  LoanStrategy.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

protocol LoanStrategy {
    func applyLoanRules(loan: inout Loan)
}
