//
//  ContentView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(AppStorageConstants.hasOpenedAppBefore.rawValue) var hasOpenedAppBefore: Bool = false

    var body: some View {
        NavigationView {
            if hasOpenedAppBefore {
                // User has opened the app before, navigate directly to the Login screen.
                LoginView()
            } else {
                // Welcome screen should only appear if the user never opened the app.
                WelcomeView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

