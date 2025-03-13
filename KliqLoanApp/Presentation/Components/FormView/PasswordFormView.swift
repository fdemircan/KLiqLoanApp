//
//  PasswordFormView.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class PasswordFormView: FormView {
    private var isSecureTextEntry: Bool = true

    override init(viewModel: FormViewModelProtocol, title: String, message: String) {
        super.init(viewModel: viewModel, title: title, message: message)
        setupPasswordField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPasswordField() {
        textField.isSecureTextEntry = true
        buttonRight.isHidden = false
        buttonRight.addTarget(self, action: #selector(buttonRightTapped), for: .touchUpInside)
    }

    @objc private func buttonRightTapped() {
        isSecureTextEntry.toggle()
        textField.isSecureTextEntry = isSecureTextEntry

        let image = isSecureTextEntry ?
            UIImage(systemName: "eye") :
            UIImage(systemName: "eye.slash")
        buttonRight.setImage(image, for: .normal)
    }
}
