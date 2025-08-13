//
//  String+Extension.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 05/08/25.
//

import Foundation

extension String {
    func toDateFromISO8601() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self)
        ?? ISO8601DateFormatter().date(from: self)
    }
}
