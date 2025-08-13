//
//  ExpenseCategoryEnum.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 03/08/25.
//

import Foundation
import SwiftUI

enum ExpenseCategoryEnum: String, Codable {
    
    case electronics = "Electronics"
    case books = "Books"
    case clothing = "Clothing"
    case homeKitchen = "Home & Kitchen"
    case sportsOutdoors = "Sports & Outdoors"
    case healthPersonalCare = "Health & Personal Care"
    case toysGames = "Toys & Games"
    case automotive = "Automotive"
    case beautyGrooming = "Beauty & Grooming"
    case petSupplies = "Pet Supplies"
    case groceryGourmetFood = "Grocery & Gourmet Food"
    case officeSupplies = "Office Supplies"
    case diningOut = "Dining Out"
    
    var id: String { self.rawValue }
    
    var iconString: String {
        switch self {
        case .electronics: return "desktopcomputer"
        case .books: return "book.closed"
        case .clothing: return "tshirt"
        case .homeKitchen: return "house.fill"
        case .sportsOutdoors: return "sportscourt"
        case .healthPersonalCare: return"cross.case.fill"
        case .toysGames: return "gamecontroller"
        case .automotive: return "car.fill"
        case .beautyGrooming: return "sparkles"
        case .petSupplies: return "pawprint.fill"
        case .groceryGourmetFood: return "cart.fill"
        case .officeSupplies: return "folder.fill"
        case .diningOut: return "fork.knife"
        }
    }
}
