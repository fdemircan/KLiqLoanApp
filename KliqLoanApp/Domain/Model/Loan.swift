//
//  Loan.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

struct Loan: Codable {
    var name: String
    var principal_amount: Double
    var interest_rate: Double
    var status: LoanStatus
    var due_in: Int // Gün cinsinden vade süresi
}

enum LoanStatus: String, Codable {
    case active = "active"
    case overdue = "overdue"
    case defaulted = "default"
}
