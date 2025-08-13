//
//  ButtonView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI

struct ButtonView: View {
    
    var buttonText: String
    var textColor: Color
    var bgColor: Color
    var strokeColor: Color? = nil
    var strokeWidth: CGFloat? = nil
    var onTap: () async -> Void
    
    
    var body: some View {
        Button {
            Task {
                await onTap()
            }
        } label: {
            Text(buttonText)
                .foregroundStyle(textColor)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(bgColor)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(strokeColor ?? .clear, lineWidth: strokeWidth ?? 1)
                }
        }
        
    }
}

#Preview {
    ButtonView(buttonText: "Create Account", textColor: .white, bgColor: Color.blue, onTap: { })
}
