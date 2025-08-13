//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation

struct TransactionModel: Decodable, Identifiable {
    let id: String
    let userId: String
    let name: String
    let type: String
    let category: String
    let amount: Double
    let date: String
    let icon: String?
    
    // Map _id from JSON to id in Swift
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case name
        case type
        case category
        case amount
        case date
        case icon
    }
}
