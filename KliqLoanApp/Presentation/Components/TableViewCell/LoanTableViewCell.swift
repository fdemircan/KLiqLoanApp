//
//  LoanTableViewCell.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import UIKit

class LoanTableViewCell: BaseTableViewCell {
    // MARK: - UI Components
   
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let amountStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constants.spacing * 2
        return stack
    }()

    private let nameLabel = HeadlineLabel()
    private let statusLabel = StatusLabel()
    private let principalLabel = BasicLabel()
    private let interestLabel = BasicLabel()

    // MARK: - Functions
    
    override func setupAdditionalUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(statusLabel)
        mainStackView.addArrangedSubview(amountStackView)

        amountStackView.addArrangedSubview(principalLabel)
        amountStackView.addArrangedSubview(interestLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.padding),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.padding)
        ])
    }

    func configure(with loan: Loan) {
        nameLabel.text = loan.name
        statusLabel.setStatus(loan.status)
        principalLabel.text = "Kredi Tutarı: ₺\(loan.principal_amount)"
        interestLabel.text = "Faiz: %\(loan.interest_rate)"
    }

}
