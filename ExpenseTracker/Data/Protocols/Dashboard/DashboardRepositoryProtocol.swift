//
//  DashboardRepositoryProtocol.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation
import Combine

protocol DashboardRepositoryProtocol {
    func getDashboardData() -> AnyPublisher<DashboardResponseModel, Error>
}
