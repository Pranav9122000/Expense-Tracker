//
//  SecureFieldView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI

struct SecureFieldView: View {
    var defaultText: String
    @Binding var text: String
    @State var showPassword: Bool = false
    var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if showPassword {
                TextFieldView(defaultText: defaultText, text: $text, isFocused: isFocused)
            } else {
                SecureField(defaultText, text: $text)
                    .padding()
                    .frame(height: 60)
                    .background {
                        Rectangle()
                            .stroke(isFocused ? Color.primary : Color.base, lineWidth: isFocused ? 2 : 1)
                    }
            }
            
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundStyle(isFocused ? Color.primary : Color.base)
                    .padding(.trailing)
            }
        }
    }
}

#Preview {
    SecureFieldView(defaultText: "Password", text: .constant(""), isFocused: false)
}
