//
//  FirestoreManager.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager {
    
    static let shared = FirestoreManager()
    var ref: DocumentReference? = nil
    let db = Firestore.firestore()
    private let USER_COLLECTION = "users"
    
    private init() {}
    
    // MARK: - Create
    func create(_ user: FirestoreUser) {
        let data: [String: Any] = [
            "pseudo": user.pseudo
        ]
        db.collection(USER_COLLECTION).document(user.uid).setData(data) { error in
            guard error == nil else {
                print("Error saving user \(user.uid) to Firestore", error?.localizedDescription ?? "No error description")
                return
            }
        }
    }

    
    // MARK: - Read
    func read(_ id: String) async -> FirestoreUser? {
        var localUser: FirestoreUser?
        let docRef = db.collection(USER_COLLECTION).document(id)
        
        do {
            let doc = try await docRef.getDocument()
            if let data = doc.data() {
                localUser = FirestoreUser.parse(data, for: id)
            }
        } catch let error {
            print("Error getting document for id \(id):", error.localizedDescription)
        }
        
        return localUser
    }
    
    // MARK: - Update
    func updatePseudo(_ pseudo: String, for userID: String) {
        let data: [String: Any] = [
            "pseudo": pseudo
        ]
        db.collection(USER_COLLECTION).document(userID).setData(data, merge: true) { error in
            guard error == nil else {
                print("Error updating user pseudo \(pseudo) for user \(userID) to Firestore", error?.localizedDescription ?? "No error description")
                return
            }
        }
    }
    
    func updateProfilePicturePath(_ path: String, for userID: String) {
        let data: [String: Any] = [
            "profilePicturePath": path
        ]
        db.collection(USER_COLLECTION).document(userID).setData(data, merge: true) { error in
            guard error == nil else {
                print("Error updating user profile picture path \(path) for \(userID) to Firestore", error?.localizedDescription ?? "No error description")
                return
            }
        }
    }

    // MARK: - Delete
}
