//
//  TokenService.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import Foundation
import Combine

struct TokenService: TokenProtocol {
    
    static func refreshToken(refreshToken: String) -> AnyPublisher<APITokenResponseModel, any Error> {
        let headers = ["Content-Type": "application/json"]
        let body: [String: String] = [
            "refreshToken": refreshToken
        ]
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            return Fail(error: URLError(.cannotDecodeContentData))
                .eraseToAnyPublisher()
        }
        
        let request = APIRequest(
            endpoint: APIEndpoints.Auth.refreshToken,
            method: .post,
            headers: headers,
            body: bodyData
        )
        
        
        return APIClient.performCombine(request, responseType: APITokenResponseModel.self)
    }
}
