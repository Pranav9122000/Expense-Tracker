//
//  TextFieldView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI

struct TextFieldView: View {
    var defaultText: String
    @Binding var text: String
    var isFocused: Bool
    
    var body: some View {
        TextField(defaultText, text: $text)
            .padding()
            .frame(height: 60)
            .background {
                Rectangle()
                    .stroke(isFocused ? Color.primary : Color.base, lineWidth: isFocused ? 2 : 1)
            }
    }
}

#Preview {
    TextFieldView(defaultText: "Email", text: .constant(""), isFocused: true)
}
