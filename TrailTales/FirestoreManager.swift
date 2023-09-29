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
    
    init() {}
    
    // MARK: - Create
    func create(_ user: LocalUserFirestore) {
        let data: [String: Any] = [
            "pseudo": user.pseudo,
        ]
        db.collection(USER_COLLECTION).document(user.uid).setData(data) { error in
            guard error == nil else {
                print("Error saving user \(user.uid) to Firestore", error?.localizedDescription ?? "No error description")
                return
            }
        }
    }
    
    // MARK: - Read
    func read(_ id: String) {
        let docRef = db.collection("users").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func isUserInFirestore(_ id: String) async -> Bool {
        var exists = false
        let docRef = db.collection("users").document(id)
        
        do {
            let doc = try await docRef.getDocument()
            exists = doc.exists
        } catch let error {
            print("Error getting document for \(id):", error.localizedDescription)
        }
        
        return exists
    }
    
    // MARK: - Update
    // MARK: - Delete
}
