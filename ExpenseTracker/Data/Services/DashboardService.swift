//
//  DashboardService.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation
import Combine

class DashboardService: DashboardServiceProtocol {
    
    func getDashboardData() -> AnyPublisher<DashboardResponseModel, Error>{
        var headers: [String: String] = [:]
        let accessToken = KeychainHelper.shared.read(for: "accessToken") ?? ""
        headers["Authorization"] = "Bearer \(accessToken)"
        headers["Content-Type"] = "application/json"
        
        let request = APIRequest(
            endpoint: APIEndpoints.Dashboard.dashboard,
            method: .get,
            headers: headers,
            body: nil
        )
        
        return APIClient.performCombine(request, responseType: DashboardResponseModel.self)
    }
}
