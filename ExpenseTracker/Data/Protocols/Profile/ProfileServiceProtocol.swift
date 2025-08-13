//
//  ProfileServiceProtocol.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 11/08/25.
//

import Foundation
import Combine

protocol ProfileServiceProtocol {
    func getProfileData() -> AnyPublisher<ProfileResponseModel, Error>
    //func updateProfileData(name: String, email: String, mobileNumber: String) -> AnyPublisher<ProfileResponseModel, Error>
}
