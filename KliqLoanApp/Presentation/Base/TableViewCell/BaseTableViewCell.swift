//
//  BaseTableViewCell.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 8
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBaseUI()
        setupAdditionalUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func setupBaseUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    func setupAdditionalUI() {
        // Alt sınıflar tarafından override edilecek
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Alt sınıflar tarafından override edilecek
    }
}
