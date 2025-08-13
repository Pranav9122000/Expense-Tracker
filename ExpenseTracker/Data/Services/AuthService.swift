//
//  AuthService.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation
import Combine

class AuthService: AuthServiceProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    func login(email: String, password: String) async throws -> RegisterUserResponseModel {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        let json = ["identifier": email, "password": password]
        let bodyData = try JSONEncoder().encode(json)
        
        let request = APIRequest(
            endpoint: APIEndpoints.Auth.login,
            method: .post,
            headers: headers,
            body: bodyData
        )
        
        return try await APIClient.performAsync(request, responseType: RegisterUserResponseModel.self)
    }
    
    func register(name: String, email: String, mobileNumber: String, password: String, profileImage: Data?) async throws -> RegisterUserResponseModel {
        var bodyData: Data?
        var headers: [String: String] = [:]
        
        if let image = profileImage {
            let boundary = UUID().uuidString
            headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
            bodyData = createMultipartBody(name: name, email: email, mobileNumber: mobileNumber, password: password, imageData: image, boundary: boundary)
        } else {
            headers["Content-Type"] = "application/json"
            let json = ["name": name, "email": email, "password": password, "mobileNumber": mobileNumber]
            bodyData = try? JSONEncoder().encode(json)
        }
        
        let request = APIRequest(
            endpoint: APIEndpoints.Auth.register,
            method: .post,
            headers: headers,
            body: bodyData
        )
        
        return try await APIClient.performAsync(request, responseType: RegisterUserResponseModel.self)
    }
    
    func findUser(email: String) async throws -> APIEmptyResponseModel {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        let json = ["identifier": email]
        let bodyData = try JSONEncoder().encode(json)
        
        let request = APIRequest(
            endpoint: APIEndpoints.Auth.findUser,
            method: .post,
            headers: headers,
            body: bodyData
        )
        
        return try await APIClient.performAsync(request, responseType: APIEmptyResponseModel.self)
    }
    
    func updatePassword(email: String, password: String) async throws -> APIEmptyResponseModel {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        let json = ["identifier": email, "password": password]
        let bodyData = try JSONEncoder().encode(json)
        
        let request = APIRequest(
            endpoint: APIEndpoints.Auth.forgotPassword,
            method: .post,
            headers: headers,
            body: bodyData
        )
        
        return try await APIClient.performAsync(request, responseType: APIEmptyResponseModel.self)
    }
    
    private func createMultipartBody(name: String, email: String, mobileNumber: String, password: String, imageData: Data, boundary: String) -> Data {
        var body = Data()
        
        let fields = [
            "name": name,
            "email": email,
            "mobileNumber": mobileNumber,
            "password": password
        ]
        
        for (key, value) in fields {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"profileImage\"; filename=\"profile.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        
        return body
    }
}
