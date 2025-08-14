//
//  View+Extension.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 13/08/25.
//

import SwiftUI

extension View {
    func loadingOverlay(isLoading: Bool) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
    
    func errorAlert(isPresented: Binding<Bool>, message: String, dismissAction: @escaping () -> Void = {}) -> some View {
        self.modifier(AlertModifier(isPresented: isPresented, message: message, dismissAction: dismissAction))
    }
}
