//
//  HomeViewModel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 12.03.2025.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeViewModelProtocol {
    var loans: BehaviorRelay<[Loan]> { get }
}

final class HomeViewModel: BaseViewModel, HomeViewModelProtocol {
    // MARK: - Properties

    private let repository: LoanRepositoryProtocol
    private let router: HomeRouterProtocol

    let loans = BehaviorRelay<[Loan]>(value: [])

    // MARK: - Initialization

    init(repository: LoanRepositoryProtocol, router: HomeRouterProtocol) {
        self.repository = repository
        self.router = router
        super.init()
        fetchLoans()
    }

    // MARK: - Functions

    func fetchLoans() {
        startLoading()

        Task {
            do {
                let fetchedLoans = try await repository.updateLoans()
                await MainActor.run {
                    self.loans.accept(fetchedLoans)
                    self.stopLoading()
                }
            } catch {
                await MainActor.run {
                    self.handleError(error)
                    self.stopLoading()
                }
            }
        }
    }
    
    func logout() {
        router.logout()
    }
}
