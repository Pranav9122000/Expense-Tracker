//
//  AlertModifier.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 13/08/25.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String
    var dismissAction: () -> Void = {}
    
    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented) {
                Button("OK", role: .cancel) {
                    isPresented = false
                    dismissAction()
                }
            } message: {
                EmptyView()
            }
    }
}
