//
//  DashboardServiceProtocol.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation
import Combine

protocol DashboardServiceProtocol {
    func getDashboardData() -> AnyPublisher<DashboardResponseModel, Error>
}
