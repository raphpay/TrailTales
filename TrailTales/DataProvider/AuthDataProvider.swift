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
    
    func login(_ user: User) async {
        // TODO: Change these two properties on main thread
        currentUser = user
        isLoggedIn = true
        guard let email = user.email else { return }
        let firestoreUser = FirestoreUser(uid: user.uid, email: email)
        FirestoreManager.shared.create(firestoreUser)
        if let user = await FirestoreManager.shared.read(user.uid) {
            let localUser = LocalUser(firebaseID: user.uid, emailAddress: user.email, pseudo: user.pseudo, profilePicturePath: user.profilePicturePath)
            LocalUserManager.shared.create(localUser)
        }
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
