//
//  ProfileViewModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 05/08/25.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    @Published var loadingState: LoadingState<ProfileResponseModel> = .idle
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    private let repository: ProfileRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: ProfileRepositoryProtocol = ProfileRepository()) {
        self.repository = repository
    }
    
    func getProfileData() {
        self.loadingState = .loading
        
        repository.getProfileData()
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingState = .idle
                case .failure(let error):
                    APIError().handleAPIErrorForViewModel(
                        error,
                        loadingState: &self.loadingState,
                        errorMessage: &self.errorMessage,
                        isError: &self.isError
                    )
                }
            } receiveValue: { [weak self] response in
                self?.user = response.data
            }
            .store(in: &cancellables)
    }
}
