//
//  WaveShape.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 31/07/25.
//

import SwiftUI

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from top-left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Draw top edge
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.8))
        
        // Draw wave with cubic curve
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.8),
            control1: CGPoint(x: rect.width * 0.35, y: rect.height),
            control2: CGPoint(x: rect.width * 0.65, y: rect.height * 0.6)
        )
        
        // Right edge and close path
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        
        return path
    }
}
