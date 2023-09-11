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
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            if hasOpenedAppBefore {
                // User has opened the app before, check login status
                if authViewModel.isLoggedIn {
                    // User is logged in, navigate to DashboardView
                    HikeListView(isLoggedIn: $authViewModel.isLoggedIn)
                } else {
                    // User is not logged in, navigate to LoginView
                    LoginView(isLoggedIn: $authViewModel.isLoggedIn)
                }
            } else {
                // Welcome screen should only appear if the user never opened the app.
                WelcomeView()
            }
        }
        .environmentObject(authViewModel)
        .onAppear {
            // Check Firebase authentication status when the app loads
            authViewModel.checkAuthStatus()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

