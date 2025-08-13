//
//  RegisterUserResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation

struct RegisterUserResponseModel: Codable {
    let statusCode: Int
    let data: UserDataModel
    let message: String
    let success: Bool
}

struct UserDataModel: Codable {
    let user: UserModel
    let accessToken: String
    let refreshToken: String
}
