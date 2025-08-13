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
            }.scrollIndicators(.hidden)
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.getDashboardData()
        }
        .overlay {
            if viewModel.loadingState == .loading {
                ProgressView()
                    .scaleEffect(2)
                    .padding(30)
                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
                    .transition(.scale)
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.isError) {
            Button("OK", role: .cancel) {
                viewModel.isError = false
                viewModel.errorMessage = ""
            }
        } message: {
            
        }
    }
}

#Preview {
    HomeView()
}
