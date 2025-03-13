//
//  StatusLabelProvider.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

final class StatusLabelProvider: LabelStyleProvider {
    enum Status: String {
        case active = "active"
        case overdue = "overdue"
        case defaulted = "default"

        var color: UIColor {
            switch self {
            case .active:
                return .systemGreen
            case .overdue:
                return .systemOrange
            case .defaulted:
                return .darkGray
            }
        }
    }

    private var currentStatus: Status = .defaulted

    var font: UIFont {
        return .systemFont(ofSize: 14, weight: .regular)
    }

    var textColor: UIColor {
        return currentStatus.color
    }

    func updateStatus(_ status: LoanStatus) {
        currentStatus = Status(rawValue: status.rawValue) ?? .defaulted
    }
}
