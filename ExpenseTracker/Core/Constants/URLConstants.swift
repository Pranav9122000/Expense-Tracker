//
//  URLConstants.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation

enum APIBase {
    static let baseURL = "http://localhost:3000/api"
    static let version = "/v1"
}

enum APIEndpoints {
    enum Auth {
        static let register = "/auth/register"
        static let login = "/auth/login"
        static let findUser = "/auth/find-user"
        static let forgotPassword = "/auth/forgot-password"
        static let logout = "/auth/logout"
        static let refreshToken = "/auth/refresh-token"
    }
    
    enum Dashboard {
        static let dashboard = "/dashboard"
    }
    
    enum Profile {
        static let getProfile = "/user/profile"
        static let updateProfile = "/user/profile"
        static let updateProfileImage = "/user/profile-image"
    }
}
