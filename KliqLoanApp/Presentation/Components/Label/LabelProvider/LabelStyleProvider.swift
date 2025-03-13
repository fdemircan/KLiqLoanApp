//
//  LabelProvider.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 8.03.2025.
//

import UIKit

protocol LabelStyleProvider {
    var textColor: UIColor { get }
    var font: UIFont { get }
    var alignment: NSTextAlignment { get }
    var numberOfLines: Int { get }
}

extension LabelStyleProvider {
    var textColor: UIColor { return .accent }
    var font: UIFont { return .systemFont(ofSize: 14) }
    var alignment: NSTextAlignment { return .left }
    var numberOfLines: Int { return 1 }
}
