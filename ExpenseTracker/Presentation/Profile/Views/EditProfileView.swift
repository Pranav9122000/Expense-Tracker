//
//  EditProfileView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 13/08/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    @State private var showImagePicker: Bool = false
    @FocusState var focusedField: FieldEnum?
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: 3)
                        )
                } else {
                    ProfileImageView(imageURL: "https://picsum.photos/300/300")
                }
                
                Image(systemName: "plus")
                    .font(.title3).bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.primary, in: .circle)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }
            }.padding(.vertical)
            
            VStack(alignment: .leading) {
                Text("User Name")
                    .font(.system(.title3, weight: .medium))
                
                TextFieldView(defaultText: viewModel.user?.name ?? "", text: $viewModel.userName, isFocused: focusedField == .fullName)
                    .focused($focusedField, equals: .fullName)
                    .padding(.bottom, 8)
                
                Text("Email")
                    .font(.system(.title3, weight: .medium))
                
                TextFieldView(defaultText: viewModel.user?.email ?? "", text: $viewModel.email, isFocused: focusedField == .email)
                    .focused($focusedField, equals: .email)
                    .padding(.bottom, 8)
                
                Text("Mobile Number")
                    .font(.system(.title3, weight: .medium))
                
                TextFieldView(defaultText: viewModel.user?.mobileNumber ?? "", text: $viewModel.phoneNumber, isFocused: focusedField == .mobile)
                    .focused($focusedField, equals: .mobile)
                    .padding(.bottom, 8)
            }.padding()
            
            ButtonView(buttonText: "Save", textColor: .white, bgColor: Color.primary) {
                
            }.font(.system(.title2, weight: .bold))
                .padding()
            Spacer()
        }
        .toolbarVisibility(.hidden, for: .tabBar)
        .photosPicker(
            isPresented: $showImagePicker,
            selection: $selectedItem,
            matching: .images
        )
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = Image(uiImage: uiImage)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title2).bold()
                    
                    Text("Edit Profile")
                        .font(.title)
                }.onTapGesture {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}
