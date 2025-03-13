//
//  LoginViewController.swift
//  KliqLoanApp
//
//  Created by Yusuf Çınar on 2.02.2025.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - LoginViewController

class LoginViewController: BaseViewController<LoginViewModel> {
    // MARK: - UI Components

    private lazy var emailFormView: FormView = {
        let viewModel = EmailFormViewModel()
        let formView = FormView(
            viewModel: viewModel,
            title: "E-Posta Adresi",
            message: "E-Posta Adresi Giriniz"
        )
        formView.translatesAutoresizingMaskIntoConstraints = false
        return formView
    }()

    private lazy var passwordFormView: PasswordFormView = {
        let viewModel = PasswordFormViewModel()
        let formView = PasswordFormView(
            viewModel: viewModel,
            title: "Şifre",
            message: "Şifre Giriniz"
        )
        formView.translatesAutoresizingMaskIntoConstraints = false
        return formView
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailFormView, passwordFormView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    override func setupBindings() {
        emailFormView.textField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordFormView.textField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.login()
            })
            .disposed(by: disposeBag)
    }
}
