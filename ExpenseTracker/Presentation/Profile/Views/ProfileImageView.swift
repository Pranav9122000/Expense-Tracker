//
//  ProfileImageView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 13/08/25.
//

import SwiftUI

struct ProfileImageView: View {
    
    var imageURL: String?
    var size: CGFloat = 120
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .padding(5)
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: 3)
                )
        } placeholder: {
            ProgressView()
                .frame(width: size, height: size)
                .padding(5)
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: 3)
                )
        }
    }
}

#Preview {
    ProfileImageView()
}
