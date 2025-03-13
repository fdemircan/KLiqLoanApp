//
//  BasicLabel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import Foundation

final class BasicLabel: BaseLabel {
    override init(provider: LabelStyleProvider = BasicLabelProvider()) {
        super.init(provider: provider)
        configure(with: provider)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
