//
//  HomeViewModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 31/07/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var transactions = [TransactionModel]()
    @Published var totalBalance: Double = 0
    @Published var totalIncome: Double = 0
    @Published var totalExpense: Double = 0
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var loadingState: LoadingState<RegisterUserResponseModel> = .idle
    
    private let repository: DashboardRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: DashboardRepositoryProtocol = DashboardRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func getDashboardData() {
        self.loadingState = .loading
        
        repository.getDashboardData()
            .sink { completion in
                switch completion {
                case .finished:
                    print("✅ Dashboard API call finished")
                    self.loadingState = .idle
                case .failure(let error):
                    print("❌ Dashboard API call failed: \(error.localizedDescription)")
                    APIError().handleAPIErrorForViewModel(
                        error,
                        loadingState: &self.loadingState,
                        errorMessage: &self.errorMessage,
                        isError: &self.isError
                    )
                }
            } receiveValue: { [weak self] dashboardResponse in
                print(".dknvjkdbvldnbkjvdf   ", dashboardResponse.data.totalIncome)
                self?.totalBalance = dashboardResponse.data.totalBalance
                self?.totalIncome = dashboardResponse.data.totalIncome
                self?.totalExpense = dashboardResponse.data.totalExpenses
                
                self?.transactions = dashboardResponse.data.recentIncome.transactions
                self?.transactions.append(contentsOf: dashboardResponse.data.recentExpense.transactions)
            }
            .store(in: &cancellables)
    }
}
