//
//  RecentTransactionModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation

struct RecentTransactionModel: Decodable {
    let amount: Double
    let transactions: [TransactionModel]
}
