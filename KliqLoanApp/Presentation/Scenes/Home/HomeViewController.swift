//
//  HomeViewController.swift
//  KliqLoanApp
//
//  Created by Yusuf Çınar on 2.02.2025.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - HomeViewController
class HomeViewController: BaseViewController<HomeViewModel> {

    // MARK: - Properties

    private let tableView = UITableView()

    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }

    override func setupBindings() {
        viewModel.loans
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.register(LoanTableViewCell.self, forCellReuseIdentifier: "LoanTableViewCell")
        tableView.dataSource = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(
            title: "Çıkış",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        navigationItem.rightBarButtonItem = logoutButton
    }

    @objc private func logoutTapped() {
        viewModel.logout()
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.loans.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoanTableViewCell", for: indexPath) as? LoanTableViewCell else {
            return UITableViewCell()
        }
        let loan = viewModel.loans.value[indexPath.row]
        cell.configure(with: loan)
        return cell
    }
}
