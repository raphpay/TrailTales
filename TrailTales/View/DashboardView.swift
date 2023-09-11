//
//  DashboardView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseAuth

struct DashboardView: View {
    @State private var userEmail: String = ""
    
    var body: some View {
        Text("Hello, \(userEmail)!")
            .onAppear {
                getCurrentUser()
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
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
