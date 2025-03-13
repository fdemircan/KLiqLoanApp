//
//  StatusLabel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class StatusLabel: BaseLabel {
    private let statusProvider: StatusLabelProvider

    init() {
        self.statusProvider = StatusLabelProvider()
        super.init(provider: statusProvider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStatus(_ status: LoanStatus) {
        statusProvider.updateStatus(status)
        text = status.rawValue
        textColor = statusProvider.textColor
    }
}
