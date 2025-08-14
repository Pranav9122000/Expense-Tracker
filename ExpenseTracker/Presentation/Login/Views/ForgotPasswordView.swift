//
//  ForgotPasswordView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @FocusState var focusedField: FieldEnum?
    @EnvironmentObject var router: Router<LoginDestinations>
    
    var body: some View {
        ZStack {
            if viewModel.isUserFound {
                VStack {
                    UserFoundView()
                        .transition(.scale.combined(with: .opacity))
                    
                    ButtonView(buttonText: "Change Password", textColor: .white, bgColor: Color.primary) {
                        Task {
                            let success = await viewModel.updatePassword()
                            if success {
                                router.navigate(to: LoginDestinations.login)
                            }
                        }
                    }
                    .font(.system(.title2, weight: .semibold))
                    
                    Spacer()
                }
            } else {
                VStack(alignment: .leading) {
                    Text("Please enter your Email or Mobile Number")
                        .padding(.top)
                        .font(.headline)
                        .foregroundStyle(focusedField == .email ? Color.primary : .base)
                    
                    TextFieldView(defaultText: "", text: $viewModel.email, isFocused: focusedField == .email)
                        .focused($focusedField, equals: .email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding(.bottom)
                    
                    ButtonView(buttonText: "Find Your Account", textColor: .white, bgColor: Color.primary) {
                        await viewModel.findUser()
                    }
                    .font(.system(.title2, weight: .semibold))
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .onAppear {
            viewModel.password = ""
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
        .toolbar {
            if !viewModel.isUserFound {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.title3).bold()
                            .onTapGesture {
                                router.navigateBack()
                            }
                        Text("Forgot Password")
                            .font(.title).bold()
                    }.foregroundStyle(Color.primary)
                }
            }
        }
        .loadingOverlay(isLoading: viewModel.loadingState == .loading)
        .errorAlert(isPresented: $viewModel.isError, message: viewModel.errorMessage) {
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
    }
    
    @ViewBuilder
    private func UserFoundView() -> some View {
        VStack(alignment: .leading) {
            Text("User Found with Email/Mobile Number")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            // viewModel.email
            Text("1234567890")
                .font(.headline)
            Divider()
            
            Text("Enter new password")
                .font(.headline)
                .foregroundStyle(focusedField == .password ? Color.primary : .base)
            
            SecureFieldView(defaultText: "Enter Your New Password", text: $viewModel.password, isFocused: focusedField == .password)
                .focused($focusedField, equals: .password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.bottom)
            
            Text("Confirm new Password")
                .font(.headline)
                .foregroundStyle(focusedField == .confirmPassword ? Color.primary : .base)
            
            SecureFieldView(defaultText: "Enter Your New Password", text: $viewModel.confirmPassword, isFocused: focusedField == .confirmPassword)
                .focused($focusedField, equals: .confirmPassword)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.bottom)
        }
    }
}

#Preview {
    ForgotPasswordView(viewModel: LoginViewModel())
}
