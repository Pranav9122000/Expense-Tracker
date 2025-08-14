//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 31/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                WaveShape()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.primary40, Color.primary60]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .frame(height: 250)
                
                VStack(alignment: .leading) {
                    Text("Good Morning")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Pranav")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    BalancesCardView(viewModel: viewModel)
                }
                .padding(.top, 40)
                .padding()
                
            }
            
            Text("My Tranactions")
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView {
                ForEach(viewModel.transactions) { transaction in
                    TransactionCardView(transaction: transaction)
                }
                
                ForEach(1..<12) { _ in
                    TransactionCardView(transaction: DummyData.transaction)
                }
            }.scrollIndicators(.hidden)
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.getDashboardData()
        }
        .loadingOverlay(isLoading: viewModel.loadingState == .loading)
        .errorAlert(isPresented: $viewModel.isError, message: viewModel.errorMessage) {
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
    }
}

#Preview {
    HomeView()
}
