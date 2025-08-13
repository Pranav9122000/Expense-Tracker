//
//  IncomeCategoryEnum.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation

enum IncomeCategory: String, Codable {
    case salary = "Salary"
    case businessIncome = "Business Income"
    case freelanceIncome = "Freelance Income"
    case investmentIncome = "Investment Income"
    case otherIncome = "Other Income"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .salary: return "dollarsign.circle.fill"
        case .businessIncome: return "briefcase.fill"
        case .freelanceIncome: return "laptopcomputer"
        case .investmentIncome: return "chart.bar.fill"
        case .otherIncome: return "questionmark.circle.fill"
        }
    }
}
