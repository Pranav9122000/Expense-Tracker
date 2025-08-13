//
//  Color+Extension.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 19/07/25.
//

import Foundation
import SwiftUI

extension Color {
    
    //MARK: Indigo color
    static let primary = Color(hex: "#2752E7")
    static let primary20 = Color(hex: "#5275EC")
    static let primary40 = Color(hex: "#7D97F1")
    static let primary60 = Color(hex: "#D0DBFF")
    static let primary80 = Color(hex: "#F5F8FE")
    
    //MARK: Orange color
    static let secondary = Color(hex: "#3F845F")
    static let secondary20 = Color(hex: "#FFD899")
    static let secondary40 = Color(hex: "#FFE5BB")
    static let secondary60 = Color(hex: "#FFF2DD")
    static let secondary80 = Color(hex: "#FFF9EF")
    
    //MARK: Black color
    static let base = Color(hex: "#2C3131")
    static let base20 = Color(hex: "#626262")
    static let base40 = Color(hex: "#A9A9A9")
    static let base60 = Color(hex: "#CACACA")
    static let base80 = Color(hex: "#E9E9E9")
    
    //MARK: Green color
    static let success = Color(hex: "#3F845F")
    static let success20 = Color(hex: "#659D7F")
    static let success40 = Color(hex: "#8CB59F")
    static let success60 = Color(hex: "#B2CEBF")
    static let success80 = Color(hex: "#D9E6DF")
    
    //MARK: Yellow color
    static let warning = Color(hex: "#E4C65B")
    static let warning20 = Color(hex: "#E9D17C")
    static let warning40 = Color(hex: "#EFDD9D")
    static let warning60 = Color(hex: "#F4E8BD")
    static let warning80 = Color(hex: "#FAF4DE")
    
    //MARK: Red color
    static let error = Color(hex: "#E25C5C")
    static let error20 = Color(hex: "#E87D7D")
    static let error40 = Color(hex: "#EE9D9D")
    static let error60 = Color(hex: "#F3BEBE")
    static let error80 = Color(hex: "#F9DEDE")
    
    //MARK: Blue color
    static let info = Color(hex: "#2685CA")
    static let info20 = Color(hex: "#519DD5")
    static let info40 = Color(hex: "#7DB6DF")
    static let info60 = Color(hex: "#A8CEEA")
    static let info80 = Color(hex: "#D4E7F4")
    
    
    /// Initialize a Color from a HEX string.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        // Check for a leading `#` and remove it.
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
