//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 19/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
                print("✅ API_KEY from xcconfig: \(apiKey)")
            } else {
                print("❌ API_KEY not found in Info.plist")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
