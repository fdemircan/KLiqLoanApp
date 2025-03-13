//
//  BaseView.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import UIKit
import RxSwift

protocol BaseViewable {
    func prepareUI()
}

class BaseView: UIView, BaseViewable {
    let disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)
        prepareUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    func prepareUI() { }
}
