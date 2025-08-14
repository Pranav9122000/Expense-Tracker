//
//  LoadingModifier.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 13/08/25.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .padding(30)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.25), value: isLoading)
                }
            }
    }
}

