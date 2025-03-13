//
//  LoanRepository.swift
//  KliqLoanApp
//
//  Created by Yusuf Çınar on 2.02.2025.
//

import Foundation

protocol LoanRepositoryProtocol {
    func updateLoans() async throws -> [Loan]
}

class LoanRepository: LoanRepositoryProtocol {
    private let loanService: LoanServicable

    init(service: LoanServicable) {
        self.loanService = service
    }

    func updateLoans() async throws -> [Loan] {
        var loans = try await loanService.loadLoans()

        for i in 0..<loans.count {
            let strategy = LoanStrategyFactory.createStrategy(for: loans[i])
            strategy.applyLoanRules(loan: &loans[i])
        }

        try await loanService.saveLoans(loans)
        return loans
    }
}
