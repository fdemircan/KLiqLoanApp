//
//  LoanStrategyFactory.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class LoanStrategyFactory {
    static func createStrategy(for loan: Loan) -> LoanStrategy {
        switch loan.status {
        case .active:
            return ActiveLoanStrategy()
        case .overdue:
            return OverdueLoanStrategy()
        case .defaulted:
            return DefaultLoanStrategy()
        }
    }
}
