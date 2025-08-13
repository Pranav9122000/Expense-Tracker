//
//  TokenProtocol.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import Foundation
import Combine

protocol TokenProtocol {
    static func refreshToken(refreshToken: String) -> AnyPublisher<APITokenResponseModel, Error>
}
