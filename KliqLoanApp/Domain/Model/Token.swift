//
//  Token.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation

struct Token: Codable {
    let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
