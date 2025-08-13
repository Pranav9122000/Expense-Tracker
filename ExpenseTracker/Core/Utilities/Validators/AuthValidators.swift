//
//  AuthValidators.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 27/07/25.
//

import Foundation

struct AuthValidators {
    
    static func validateForLogin(input: String, password: String) -> (isValid: Bool, error: String?) {
        if input.isEmpty {
            return (false, "Email or mobile number is required.")
        }

        let isEmail = isValidEmail(input)
        let isPhone = isValidPhoneNumber(input)

        if !isEmail && !isPhone {
            return (false, "Enter a valid email or mobile number.")
        }

        if password.isEmpty {
            return (false, "Password cannot be empty.")
        }

        if password.count < 6 {
            return (false, "Password must be at least 6 characters.")
        }

        return (true, nil)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    static func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^[0-9]{10,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: number)
    }
}
