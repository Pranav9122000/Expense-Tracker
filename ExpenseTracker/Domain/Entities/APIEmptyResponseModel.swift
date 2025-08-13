//
//  APIEmptyResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 28/07/25.
//

import Foundation

struct APIEmptyResponseModel: Codable {
    let statusCode: Int
    let message: String
    let success: Bool
}
