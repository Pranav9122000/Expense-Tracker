//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 02/08/25.
//

import SwiftUI

struct TransactionCardView: View {
    
    let transaction: TransactionModel
    
    var body: some View {
        HStack(alignment: .top) {
            if let icon = transaction.icon {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(.headline)
                Text("\(transaction.date.toDateFromISO8601()?.formattedDate() ?? "No Date")")
                    .font(.subheadline)
            }
            Spacer()
        
            Text("\(transaction.amount.formatCurrency())")
                .font(.title3)
                .bold()
        }
        .padding()
        .background(transaction.type == "income" ? Color.success.gradient :  Color.error.gradient, in: .rect(cornerRadius: 20))
        .padding(.horizontal)
        .foregroundStyle(.white)
    }
}

#Preview {
    TransactionCardView(transaction: DummyData.transaction)
}

struct DummyData {
    static let transaction: TransactionModel = .init(id: "1", userId: "1", name: "Eating Out", type: "expense", category: "diningOut", amount: 1234.989, date: "2025-08-02T12:34:56Z", icon: "pawprint.fill")
    
    static let transactions: [TransactionModel] = Array(repeating: transaction, count: 10)
}
