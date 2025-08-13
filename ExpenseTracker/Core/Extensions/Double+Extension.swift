//
//  Double+Extension.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 02/08/25.
//

import SwiftUI

extension Double {
    func formatCurrency() -> String {
        return String(format: "₹ %.2f", self)
    }
    
    func trailingZeroesRemoved() -> String {
        let formatted = String(format: "%.2f", self)
        if formatted.hasSuffix(".00") {
            return String(formatted.dropLast(3))
        } else if formatted.hasSuffix("0") {
            return String(formatted.dropLast(1))
        }
        return formatted
    }
}
