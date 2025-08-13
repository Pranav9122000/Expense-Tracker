//
//  Date+Extension.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 02/08/25.
//

import SwiftUI

extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}
