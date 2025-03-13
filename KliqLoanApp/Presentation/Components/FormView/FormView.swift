//
//  FormView.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa

class FormView: BaseView {
    // MARK: - Properties
    var viewModel: FormViewModelProtocol?

    private let labelTitle: BasicLabel = BasicLabel()
    private let labelMessage: BasicLabel = BasicLabel()
    private let labelError: ErrorLabel = ErrorLabel()

    private let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return stackView
    }()

    let buttonRight: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // MARK: - Functions

    init(viewModel: FormViewModelProtocol, title: String, message: String) {
        self.viewModel = viewModel
        super.init()
        
        labelTitle.text = title
        textField.placeholder = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareUI() {
        super.prepareUI()

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelError.translatesAutoresizingMaskIntoConstraints = false

        viewContainer.addSubview(textField)
        viewContainer.addSubview(buttonRight)

        addSubview(stackView)
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(viewContainer)
        stackView.addArrangedSubview(labelError)
        stackView.addArrangedSubview(labelMessage)

        textField.delegate = self
        prepareUIConstraints()
        setupBinding()
    }

    // MARK: - Private Functions

    private func prepareUIConstraints() {
        NSLayoutConstraint.activate([
            // stackView constraints
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),

            // viewContainer height constraint
            viewContainer.heightAnchor.constraint(equalToConstant: 48),

            // textField Constraints
            textField.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            textField.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: buttonRight.leadingAnchor, constant: -16),

            // buttonRight Constraints
            buttonRight.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16),
            buttonRight.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            buttonRight.widthAnchor.constraint(equalToConstant: 24),
            buttonRight.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupBinding() {
        guard let viewModel = viewModel else { return }

        textField.rx.text.orEmpty
            .bind(to: viewModel.selectedValue)
            .disposed(by: disposeBag)

        viewModel.validationResult
            .skip(1)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] result in
                switch result {
                case .success:
                    self?.hideError()
                case .failure(let message):
                    self?.showError(message)
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Error Alerts Functions

extension FormView {
    func showError(_ errorMessage: String) {
        labelError.text = errorMessage
        labelError.isHidden = false
        labelMessage.isHidden = true
        viewContainer.layer.borderColor = UIColor.red.cgColor
    }

    func hideError() {
        labelError.isHidden = true
        labelMessage.isHidden = true
        viewContainer.layer.borderColor = UIColor.black.cgColor
    }
}

// MARK: - UITextFieldDelegate

extension FormView: UITextFieldDelegate {

}
