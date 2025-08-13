//
//  ProfileResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 11/08/25.
//

import Foundation

struct ProfileResponseModel: Codable {
    let statusCode: Int
    let data: UserModel
    let message: String
    let success: Bool
}
