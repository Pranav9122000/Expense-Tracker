//
//  TabbarView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 31/07/25.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Cards", systemImage: "house.fill") {
                
            }
            
            Tab("Stats", systemImage: "house.fill") {
                
            }
            
            Tab("Profile", systemImage: "person.circle.fill") {
                ProfileView()
            }
        }.background(Color.gray.ignoresSafeArea(edges: .bottom))
    }
}

#Preview {
    TabbarView()
}
