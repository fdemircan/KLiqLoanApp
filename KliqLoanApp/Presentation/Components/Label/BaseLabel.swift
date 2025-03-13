//
//  BaseLabel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 7.03.2025.
//

import UIKit

class BaseLabel: UILabel {
    private var provider: LabelStyleProvider

    init(provider: LabelStyleProvider) {
        self.provider = provider
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with provider: LabelStyleProvider) {
        self.provider = provider

        textColor = provider.textColor
        font = provider.font
        textAlignment = provider.alignment
        numberOfLines = provider.numberOfLines
    }
}
