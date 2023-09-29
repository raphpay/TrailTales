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
    func save(_ id: String) {
        // Add a new document with a generated ID
//        ref = db.collection("users").addDocument(data: [
//            "first": "Ada",
//            "last": "Lovelace",
//            "born": 1815
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(self.ref?.documentID ?? "No firestore ref available")")
//            }
//        }
        
        // Add document with custom ID
        let data: [String: Any] = [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1928
        ]
        db.collection("users").document(id).setData(data)
    }
    
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
//        db.collection("users").getDocuments() { (querySnapshot, error) in
//            guard error == nil,
//                  let snapshot = querySnapshot else {
//                print("Error getting documents from Firestore", error!.localizedDescription)
//                return
//            }
//
//            for document in snapshot.documents {
//                print("\(document.documentID) => \(document.data())")
//            }
//        }
        
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
    
    // MARK: - Update
    // MARK: - Delete
}
