//
//  DashboardRepository.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation
import Combine

class DashboardRepository: DashboardRepositoryProtocol {
    private let service: DashboardServiceProtocol
    
    init(service: DashboardServiceProtocol = DashboardService()) {
        self.service = service
    }
    
    func getDashboardData() -> AnyPublisher<DashboardResponseModel, Error> {
        return service.getDashboardData()
    }
}
