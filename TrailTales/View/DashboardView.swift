//
//  DashboardView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseAuth

struct DashboardView: View {
    
    @Binding var isLoggedIn: Bool
    @State private var userEmail: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(userEmail)!")
                .onAppear {
                    getCurrentUser()
                }
            Button {
                signOut()
            } label: {
                Text("Sign out")
            }

        }
        .navigationBarBackButtonHidden()
    }
    
    func getCurrentUser() {
        if let user = Auth.auth().currentUser,
           let mail = user.email {
          userEmail = mail
        } else {
          // No user is signed in.
          // ...
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isLoggedIn: .constant(true))
    }
}
