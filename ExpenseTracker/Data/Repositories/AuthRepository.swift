//
//  AuthRepository.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation
import Combine

class AuthRepository: AuthRepositoryProtocol {
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    func register(name: String, email: String, mobileNumber: String, password: String, profileImage: Data?) async throws -> RegisterUserResponseModel {
        return try await service.register(name: name, email: email, mobileNumber: mobileNumber, password: password, profileImage: profileImage)
    }
    
    func login(email: String, password: String) async throws -> RegisterUserResponseModel {
        return try await service.login(email: email, password: password)
    }
    
    func findUser(email: String) async throws -> APIEmptyResponseModel {
        return try await service.findUser(email: email)
    }
    
    func updatePassword(email: String, password: String) async throws -> APIEmptyResponseModel {
        return try await service.updatePassword(email: email, password: password)
    }
}
