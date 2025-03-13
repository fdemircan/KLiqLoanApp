//
//  BaseViewModel.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation
import RxSwift
import RxRelay

protocol BaseViewModelProtocol {
    var isLoading: BehaviorRelay<Bool> { get }
    var error: PublishRelay<String> { get }
    var disposeBag: DisposeBag { get }
}

class BaseViewModel: BaseViewModelProtocol {
    // MARK: - Properties
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishRelay<String>()
    let disposeBag = DisposeBag()

    // MARK: - Initialization
    init() {}

    // MARK: - Error Handling
    func handleError(_ error: Error) {
        if let authError = error as? AuthError {
            self.error.accept(authError.localizedDescription)
        } else {
            self.error.accept("Bilinmeyen bir hata oluştu")
        }
    }

    // MARK: - Loading State
    func startLoading() {
        isLoading.accept(true)
    }

    func stopLoading() {
        isLoading.accept(false)
    }
} 
