//
//  AppRootViewModel.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 21/07/25.
//

import Foundation
import Combine

enum AppFlow {
    case splash, login, dashboard
}

class AppRootViewModel: ObservableObject {
    @Published var flow: AppFlow = .splash
    private let keyChainHelper = KeychainHelper.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateTokens()
    }
    
    func validateTokens() {
        guard let accessToken = keyChainHelper.read(for: "accessToken"),
              !isTokenExpired(token: accessToken) else {
            refreshAccessToken()
            return
        }
        flow = .dashboard
    }
    
    private func isTokenExpired(token: String) -> Bool {
        guard let payload = decodeJWT(token),
              let exp = payload["exp"] as? TimeInterval else { return true }
        
        let expirationDate = Date(timeIntervalSince1970: exp)
        return Date() >= expirationDate
    }
    
    private func refreshAccessToken() {
        guard let refreshToken = keyChainHelper.read(for: "refreshToken") else {
            flow = .login
            return
        }
        
        TokenService.refreshToken(refreshToken: refreshToken)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Token refresh succeeded")
                case .failure(let error):
                    print("Token refresh failed: \(error.localizedDescription)")
                    self.flow = .login
                }
            } receiveValue: { response in
                print("Access token is refreshed")
                self.keyChainHelper.save(response.data.accessToken, for: "accessToken")
                self.keyChainHelper.save(response.data.refreshToken, for: "refreshToken")
                self.flow = .dashboard
            }
            .store(in: &cancellables)
    }
    
    private func decodeJWT(_ token: String) -> [String: Any]? {
        let segments = token.split(separator: ".")
        guard segments.count > 1 else { return nil }
        
        let base64 = String(segments[1])
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        guard let data = Data(base64Encoded: base64),
              let json = try? JSONSerialization.jsonObject(with: data),
              let payload = json as? [String: Any] else {
            return nil
        }
        return payload
    }
}
