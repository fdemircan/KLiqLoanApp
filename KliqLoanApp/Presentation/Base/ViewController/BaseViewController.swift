//
//  BaseViewController.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {
    // MARK: - Properties
    let viewModel: T
    let disposeBag = DisposeBag()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Initialization
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBaseBindings()
        setupBindings()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupBaseBindings() {
        // Loading state binding
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        // Error handling binding
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.showError(message: message)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Methods to override
    func setupBindings() {
        // Alt sınıflar tarafından override edilecek
    }

    // MARK: - Error Handling
    func showError(message: String) {
        let alert = UIAlertController(
            title: "Hata",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
