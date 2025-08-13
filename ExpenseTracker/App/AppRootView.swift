//
//  AppRootView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 21/07/25.
//

import SwiftUI

struct AppRootView: View {
    
    @StateObject var viewModel = AppRootViewModel()
    @StateObject private var loginRouter = Router<LoginDestinations>()
    @StateObject private var dashboardRouter = Router<UserDestinations>()
    
    //View Models
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        Group {
            switch viewModel.flow {
            case .splash:
                SplashScreenView()
            case .login:
                NavigationStack(path: $loginRouter.navPath) {
                    LoginView() {
                        viewModel.flow = .dashboard
                    }
                    .environmentObject(loginRouter)
                    .navigationDestination(for: LoginDestinations.self) { destination in
                        switch destination {
                        case .login:
                            LoginView() {
                                viewModel.flow = .dashboard
                            }
                            .environmentObject(loginRouter)
                        case .register:
                            RegisterView() {
                                viewModel.flow = .dashboard
                            }
                            .environmentObject(loginRouter)
                        case .forgotPassword:
                            ForgotPasswordView(viewModel: loginViewModel)
                                .environmentObject(loginRouter)
                        }
                    }
                }
            case .dashboard:
                NavigationStack(path: $dashboardRouter.navPath) {
                    TabbarView()
                        .environmentObject(dashboardRouter)
                }
            }
        }
    }
}

#Preview {
    AppRootView()
}
