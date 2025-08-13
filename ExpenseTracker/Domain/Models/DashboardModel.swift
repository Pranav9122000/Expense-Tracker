//
//  DashboardModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation

struct DashboardModel: Decodable {
    let totalBalance: Double
    let totalIncome: Double
    let totalExpenses: Double
    let recentIncome: RecentTransactionModel
    let recentExpense: RecentTransactionModel
}
