//
//  BalancesCardView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 31/07/25.
//

import SwiftUI

struct BalancesCardView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Total Balance")
                        .font(.system(size: 18, weight: .semibold))
                    Text("\(viewModel.totalBalance.formatCurrency())")
                        .font(.system(size: 26, weight: .bold))
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.largeTitle)
                    .padding(.top, 4)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "arrow.up.circle")
                        Text("Income")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Text("\(viewModel.totalIncome.formatCurrency())")
                        .font(.system(size: 22, weight: .bold))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "arrow.down.circle")
                        Text("Expenses")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Text("\(viewModel.totalExpense.formatCurrency())")
                        .font(.system(size: 22, weight: .bold))
                }
            }
        }
        .foregroundStyle(.white)
        .padding(30)
        .background(Color.primary.gradient, in: .rect(cornerRadius: 10))
    }
}

#Preview {
    BalancesCardView(viewModel: HomeViewModel())
}


