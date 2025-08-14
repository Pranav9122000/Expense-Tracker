//
//  ProfileView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 05/08/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State private var navigateToEditProfile: Bool = false
    
    var body: some View {
        VStack {
            ProfileImageView(imageURL: viewModel.user?.profileImageUrl)
                .padding(.top)
            
            Text(viewModel.user?.name ?? "")
                .font(.title).bold()
            
            VStack(spacing: 16) {
                InfoRowView("Email", viewModel.user?.email ?? "")
                InfoRowView("Mobile Number", viewModel.user?.mobileNumber ?? "")
            }.padding()
            
            ButtonView(buttonText: "Edit Profile", textColor: .white, bgColor: Color.primary20) {
                self.navigateToEditProfile = true
            }
            .font(.title2).bold()
            .padding()
            
            ButtonView(buttonText: "Sign Out", textColor: .white, bgColor: Color.base20) {
                KeychainHelper.shared.delete(for: "accessToken")
                KeychainHelper.shared.delete(for: "refreshToken")
            }
            .font(.title2).bold()
            .padding(.horizontal)
            
            Spacer()
        }
        .toolbarVisibility(.visible, for: .tabBar)
        .onAppear {
            viewModel.getProfileData()
            self.navigateToEditProfile = false
        }
        .loadingOverlay(isLoading: viewModel.loadingState == .loading)
        .errorAlert(isPresented: $viewModel.isError, message: viewModel.errorMessage) {
            viewModel.isError = false
            viewModel.errorMessage = ""
        }
        .navigationDestination(isPresented: $navigateToEditProfile) {
            EditProfileView(viewModel: viewModel)
        }
    }
    
    @ViewBuilder
    func InfoRowView(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(.title2, weight: .semibold))
                .foregroundStyle(Color.primary)
            
            Text(value)
                .font(.title3)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProfileView()
}
