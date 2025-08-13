//
//  LoginViewModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var mobileNumber: String = ""
    @Published var isUserFound: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var loadingState: LoadingState<RegisterUserResponseModel> = .idle
    @Published var userName: String = ""
    
    private let repository: AuthRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func login() async -> Bool {
        self.loadingState = .loading
        self.errorMessage = ""
        self.isError = false
        
        print("This is email \(email) and password \(password)")
        
        do {
            let response = try await repository.login(email: email, password: password)
            self.loadingState = .loaded(response)
            
            KeychainHelper.shared.save(response.data.accessToken, for: "accessToken")
            KeychainHelper.shared.save(response.data.refreshToken, for: "refreshToken")
            return true
        }  catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                APIError().handleAPIErrorForViewModel(
                    error,
                    loadingState: &self.loadingState,
                    errorMessage: &self.errorMessage,
                    isError: &self.isError
                )
            }
            return false
        }
    }
    
    @MainActor
    func findUser() async {
        self.loadingState = .loading
        self.errorMessage = ""
        self.isError = false
        do {
            let response = try await repository.findUser(email: email)
            self.isUserFound = response.success
            self.loadingState = .idle
        } catch {
            APIError().handleAPIErrorForViewModel(
                error,
                loadingState: &self.loadingState,
                errorMessage: &self.errorMessage,
                isError: &self.isError
            )
        }
    }
    
    @MainActor
    func updatePassword() async -> Bool {
        self.loadingState = .loading
        self.errorMessage = ""
        self.isError = false
        do {
            _ = try await repository.updatePassword(email: email, password: password)
            self.loadingState = .idle
            return true
        } catch {
            APIError().handleAPIErrorForViewModel(
                error,
                loadingState: &self.loadingState,
                errorMessage: &self.errorMessage,
                isError: &self.isError
            )
            return false
        }
    }
    
    @MainActor
    func register(profileImage: Data?) async -> Bool {
        self.loadingState = .loading
        self.errorMessage = ""
        self.isError = false
        
        do {
            let response = try await repository.register(name: name, email: email, mobileNumber: mobileNumber, password: password, profileImage: profileImage)
            self.loadingState = .loaded(response)
            
            KeychainHelper.shared.save(response.data.accessToken, for: "accessToken")
            KeychainHelper.shared.save(response.data.refreshToken, for: "refreshToken")
            return true
        }  catch {
            APIError().handleAPIErrorForViewModel(
                error,
                loadingState: &self.loadingState,
                errorMessage: &self.errorMessage,
                isError: &self.isError
            )
            return false
        }
        
    }
    
    func validateInputsForLogin() -> Bool {
        let input = !email.isEmpty ? email : mobileNumber
        let result = AuthValidators.validateForLogin(input: input, password: password)
        if !result.isValid {
            self.errorMessage = result.error ?? "Invalid input"
            self.isError = true
            return false
        }
        self.isError = false
        self.errorMessage = ""
        return true
    }
}
