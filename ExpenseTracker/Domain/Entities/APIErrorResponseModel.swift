//
//  APIErrorResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 27/07/25.
//

import Foundation

struct APIErrorResponseModel: Codable, Error {
    let success: Bool
    let message: String
    let errors: [String]?
}
