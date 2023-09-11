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
    @StateObject var authDataProvider = AuthDataProvider()
    
    var body: some View {
        NavigationView {
            if hasOpenedAppBefore {
                // User has opened the app before, check login status
                if authDataProvider.isLoggedIn {
                    // User is logged in, navigate to DashboardView
                    HikeListView()
                } else {
                    // User is not logged in, navigate to LoginView
                    LoginView()
                }
            } else {
                // Welcome screen should only appear if the user never opened the app.
                WelcomeView()
            }
        }
        .environmentObject(authDataProvider)
        .onAppear {
            // Check Firebase authentication status when the app loads
            authDataProvider.checkAuthStatus()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

