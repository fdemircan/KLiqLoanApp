//
//  MockLoanRepository.swift
//  KliqLoanAppTests
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation
@testable import KliqLoanApp

enum LoanError: Error {
    case custom(String)
}

final class MockLoanRepository: LoanRepositoryProtocol {
    var mockLoans: [Loan] = []
    var mockError: String?

    func updateLoans() async throws -> [Loan] {
        if let errorMessage = mockError {
            throw LoanError.custom(errorMessage)
        }
        return mockLoans
    }
}
