//
//  ProfileRepository.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 11/08/25.
//

import Foundation
import Combine

class ProfileRepository: ProfileRepositoryProtocol {
    
    private let service: ProfileServiceProtocol
    
    init(service: ProfileServiceProtocol = ProfileService()) {
        self.service = service
    }
    
    func getProfileData() -> AnyPublisher<ProfileResponseModel, any Error> {
        return service.getProfileData()
    }
    
//    func updateProfileData(name: String, email: String, mobileNumber: String) -> AnyPublisher<ProfileResponseModel, any Error> {
//        return service.updateProfileData(name: name, email: email, mobileNumber: mobileNumber)
//    }
}
