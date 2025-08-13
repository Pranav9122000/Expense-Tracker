//
//  SplashScreenView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 27/07/25.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.primary.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                ProgressView()
                    .scaleEffect(3)
                    .padding(30)
                    .tint(.white)
                
                Text("Expense Tracker")
                    .foregroundStyle(.white)
                    .padding(.vertical, 30)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Text("Track your expenses and manage your finances effectively.")
                    .font(.title2).bold()
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
            }.padding()
        }
    }
}

#Preview {
    SplashScreenView()
}
