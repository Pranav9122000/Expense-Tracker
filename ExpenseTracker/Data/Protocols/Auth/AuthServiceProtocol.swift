//
//  AuthServiceProtocol.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation
import Combine

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> RegisterUserResponseModel
    func register(name: String, email: String, mobileNumber: String, password: String, profileImage: Data?) async throws -> RegisterUserResponseModel
    func findUser(email: String) async throws -> APIEmptyResponseModel
    func updatePassword(email: String, password: String) async throws -> APIEmptyResponseModel
}
