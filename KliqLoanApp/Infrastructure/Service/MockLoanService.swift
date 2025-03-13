//
//  MockLoanService.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

protocol LoanServicable {
    func loadLoans() async throws -> [Loan]
    func saveLoans(_ loans: [Loan]) async throws
}

class MockLoanService: LoanServicable {
    func loadLoans() async throws -> [Loan] {

        guard let url = Bundle.main.url(forResource: "loans", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "MockLoanService", code: -1, userInfo: nil)
        }
        return try JSONDecoder().decode([Loan].self, from: data)
    }

    func saveLoans(_ loans: [Loan]) async throws {
        print("Loans saved: \(loans)")
    }
}
