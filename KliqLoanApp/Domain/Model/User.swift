//
//  User.swift
//  KliqLoanApp
//
//  Created by Demircan, Fetiye on 11.03.2025.
//

import Foundation

struct User: Codable {
    let email: String

    enum CodingKeys: String, CodingKey {
        case email
    }
}
