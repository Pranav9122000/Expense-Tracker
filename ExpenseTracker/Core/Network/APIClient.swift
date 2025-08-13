//
//  APIClient.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation
import Combine

final class APIClient {
    static let shared = APIClient()
    private init() {}
    
    /// Using Combine to make network calls
    static func performCombine<T: Decodable>(_ request: APIRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let urlRequest = request.urlRequest else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    if let apiError = try? JSONDecoder().decode(APIErrorResponseModel.self, from: result.data) {
                        throw apiError
                    } else {
                        throw URLError(.init(rawValue: httpResponse.statusCode))
                    }
                }
                
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Using async/await to make network calls
    static func performAsync<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        guard let urlRequest = request.urlRequest else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if 200..<300 ~= httpResponse.statusCode {
            return try JSONDecoder().decode(T.self, from: data)
            
        } else {
            if let apiError = try? JSONDecoder().decode(APIErrorResponseModel.self, from: data) {
                throw apiError
            } else {
                throw URLError(.badServerResponse)
            }
        }
    }
}
