//
//  DashboardResponseModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation

struct DashboardResponseModel: Decodable {
    let statusCode: Int
    let data: DashboardModel
    let message: String
    let success: Bool
}
