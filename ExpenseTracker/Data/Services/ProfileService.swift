//
//  ProfileService.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 11/08/25.
//

import Foundation
import Combine

class ProfileService: ProfileServiceProtocol {
    
    func getProfileData() -> AnyPublisher<ProfileResponseModel, any Error> {
        var headers: [String: String] = [:]
        let accessToken = KeychainHelper.shared.read(for: "accessToken") ?? ""
        headers["Authorization"] = "Bearer \(accessToken)"
        headers["Content-Type"] = "application/json"
        
        let request = APIRequest(
            endpoint: APIEndpoints.Profile.getProfile,
            method: .get,
            headers: headers,
            body: nil
        )
        
        return APIClient.performCombine(request, responseType: ProfileResponseModel.self)
    }
}
