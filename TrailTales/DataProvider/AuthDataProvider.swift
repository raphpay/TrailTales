//
//  AuthDataProvider.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import Foundation
import FirebaseAuth

final class AuthDataProvider: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?

    func checkAuthStatus() {
        if let user = Auth.auth().currentUser {
            currentUser = user
            isLoggedIn = true
        }
    }
    
    func login(_ user: User) {
        currentUser = user
        isLoggedIn = true
        guard let email = user.email else { return }
        let localUser = LocalUserFirestore(uid: user.uid, email: email)
        FirestoreManager.shared.create(localUser)
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            isLoggedIn = false
        } catch let error {
            print("Sign out error", error)
        }
    }
}
