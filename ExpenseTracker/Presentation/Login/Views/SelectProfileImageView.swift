//
//  SelectProfileImageView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 05/08/25.
//

import SwiftUI
import PhotosUI

struct SelectProfileImageView: View {
    
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var profileImage: UIImage?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            ZStack {
                if let profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 3))
                } else {
                    Circle()
                        .fill(Color.black.opacity(0.6))
                        .frame(width: 120, height: 120)
                }
            }.overlay(alignment: .bottomTrailing) {
                Image(systemName: "plus")
                    .font(.title3).bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.primary, in: .circle)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
            }
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                }
            }
        }
    }
}
