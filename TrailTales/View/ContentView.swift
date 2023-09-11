//
//  ContentView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage(AppStorageConstants.hasOpenedAppBefore.rawValue) var hasOpenedAppBefore: Bool = false
    @State private var isLoggedIn: Bool = false // Add a state variable to track user login status
    
    var body: some View {
        NavigationView {
            if hasOpenedAppBefore {
                // User has opened the app before, check login status
                if isLoggedIn {
                    // User is logged in, navigate to DashboardView
                    DashboardView()
                } else {
                    // User is not logged in, navigate to LoginView
                    LoginView()
                }
            } else {
                // Welcome screen should only appear if the user never opened the app.
                WelcomeView()
            }
        }
        .onAppear {
            // Check Firebase authentication status when the app loads
            checkAuthStatus()
        }
    }
    
    // Function to check Firebase authentication status
    private func checkAuthStatus() {
        if Auth.auth().currentUser != nil {
            // User is authenticated, update the isLoggedIn state
            isLoggedIn = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

