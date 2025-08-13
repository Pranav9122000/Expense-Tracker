//
//  UserModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 26/07/25.
//

import Foundation

struct UserModel: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let mobileNumber: String
    let profileImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, mobileNumber, profileImageUrl
    }
}
