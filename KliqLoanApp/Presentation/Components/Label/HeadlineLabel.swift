//
//  HeadlineLabel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation

final class HeadlineLabel: BaseLabel {
    override init(provider: LabelStyleProvider = HeadlineLabelProvider()) {
        super.init(provider: provider)
        configure(with: provider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
