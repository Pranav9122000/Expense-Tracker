//
//  LoginView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: Router<LoginDestinations>
    @StateObject var viewModel = LoginViewModel()
    @FocusState var focusedField: FieldEnum?
    var onContinue: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("Sign in to\n Expense Tracker")
                .foregroundStyle(Color.primary)
                .font(.largeTitle).bold()
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                Text("Email/Mobile No")
                    .font(.system(.title3, weight: .medium))
                    .foregroundStyle(focusedField == .email ? Color.primary : .base)
                
                TextFieldView(defaultText: "Enter your email or mobile number", text: $viewModel.email, isFocused: focusedField == .email)
                    .focused($focusedField, equals: .email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom)
                
                Text("Password")
                    .font(.system(.title3, weight: .medium))
                    .foregroundStyle(focusedField == .password ? Color.primary : .base)
                
                SecureFieldView(defaultText: "Enter your password", text: $viewModel.password, isFocused: focusedField == .password)
                    .focused($focusedField, equals: .password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom)
                
                Text("Forgot Password")
                    .font(.system(.title2, weight: .semibold))
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        router.navigate(to: LoginDestinations.forgotPassword)
                    }
                    .padding(.bottom)
                
                ButtonView(buttonText: "Sign In", textColor: .white, bgColor: Color.primary) {
                    if viewModel.validateInputsForLogin() {
                        await handleLogin()
                    }
                }.font(.system(.title2, weight: .semibold))
                
            }.padding()
            
            Spacer()
            Divider()
                .padding(.bottom, 4)
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .font(.headline)
                Button {
                    router.navigate(to: LoginDestinations.register)
                } label: {
                    Text("Sign Up")
                        .foregroundStyle(Color.primary)
                        .font(.headline)
                        
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            viewModel.password = ""
        }
        .navigationBarBackButtonHidden(true)
        .loadingOverlay(isLoading: viewModel.loadingState == .loading)
        .errorAlert(isPresented: $viewModel.isError, message: viewModel.errorMessage) {
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
    }
    
    @MainActor
    func handleLogin() async {
        let success = await viewModel.login()
        
        if success {
            onContinue()
        } else {
            viewModel.password = ""
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(), onContinue: { })
}
