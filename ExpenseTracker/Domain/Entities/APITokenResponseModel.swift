//
//  APITokenResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 29/07/25.
//

import Foundation

struct APITokenResponseModel: Codable {
    let statusCode: Int
    let message: String
    let data: APITokenDataModel
    let success: Bool
}

struct APITokenDataModel: Codable {
    let accessToken: String
    let refreshToken: String
}
