//
//  RegisterView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 24/07/25.
//

import SwiftUI
import PhotosUI
import Combine

struct RegisterView: View {
    
    @EnvironmentObject var router: Router<LoginDestinations>
    @StateObject var viewModel = LoginViewModel()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    @FocusState var focusedField: FieldEnum?
    var onContinue: () -> Void
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            SelectProfileImageView(selectedItem: $selectedItem, profileImage: $profileImage)
            
            Text("Update you profile picture")
                .font(.title3)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading) {
                Text("Full Name")
                    .font(.system(.title3, weight: .medium))
                TextFieldView(defaultText: "Enter your first name", text: $viewModel.name, isFocused: focusedField == .fullName)
                    .focused($focusedField, equals: .fullName)
                    .padding(.bottom, 8)
                
                Text("Email")
                    .font(.system(.title3, weight: .medium))
                TextFieldView(defaultText: "Enter your email", text: $viewModel.email, isFocused: focusedField == .email)
                    .focused($focusedField, equals: .email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, 8)
                
                Text("Mobile Number")
                    .font(.system(.title3, weight: .medium))
                TextFieldView(defaultText: "Enter your email", text: $viewModel.mobileNumber, isFocused: focusedField == .mobile)
                    .focused($focusedField, equals: .mobile)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, 8)
                
                Text("Password")
                    .font(.system(.title3, weight: .medium))
                SecureFieldView(defaultText: "xxxxxxxxxx", text: $viewModel.password, isFocused: focusedField == .password)
                    .focused($focusedField, equals: .password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, 30)
                
                ButtonView(buttonText: "Create Account", textColor: .white, bgColor: Color.primary) {
                    await handleRegister()
                }.font(.system(.title2, weight: .semibold))
            }.padding()
            
            Spacer()
            Divider()
                .padding(.bottom, 4)
            HStack(spacing: 4) {
                Text("Already have an account?")
                    .font(.headline)
                Button {
                    router.navigate(to: LoginDestinations.login)
                } label: {
                    Text("Sign In")
                        .foregroundStyle(Color.primary)
                        .font(.headline)
                    
                }
            }.padding(.bottom, 4)
        }
        .toolbarVisibility(.visible, for: .navigationBar)
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .loadingOverlay(isLoading: viewModel.loadingState == .loading)
        .errorAlert(isPresented: $viewModel.isError, message: viewModel.errorMessage) {
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
    }
    
    @MainActor
    func handleRegister() async {
        let success = await viewModel.register(profileImage: profileImage?.jpegData(compressionQuality: 1))
        
        if success {
            onContinue()
        }
    }
}

#Preview {
    RegisterView(onContinue: { })
}
