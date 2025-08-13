//
//  APIRequest.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation

struct APIRequest {
    let endpoint: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?

    var urlRequest: URLRequest? {
        guard let url = URL(string: APIBase.baseURL + APIBase.version + endpoint) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = body
        return request
    }
}
