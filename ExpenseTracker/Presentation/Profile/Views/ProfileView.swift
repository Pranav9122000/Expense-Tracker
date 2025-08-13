//
//  ProfileView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 05/08/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            /// Image from backend
            AsyncImage(url: URL(string: viewModel.user?.profileImageUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(5)
                    .overlay(
                        Circle()
                            .stroke(Color.primary, lineWidth: 3)
                    )
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120)
            }
            
            Text(viewModel.user?.name ?? "")
                .font(.title).bold()

            
            VStack(spacing: 16) {
                InfoRowView("Email", viewModel.user?.email ?? "")
                InfoRowView("Mobile Number", viewModel.user?.mobileNumber ?? "")
            }.padding()
            
            ButtonView(buttonText: "Edit Profile", textColor: .white, bgColor: Color.primary20) {
                
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
        .onAppear {
            viewModel.getProfileData()
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
