//
//  FirestoreUser.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import Foundation

final class FirestoreUser: Codable {
    var uid: String = ""
    var email: String = ""
    var pseudo: String = ""
    var profilePicturePath: String?
    
    // MARK: - Initialization
    convenience init(uid: String, email: String, pseudo: String = "", profilePicturePath: String? = nil) {
        self.init()
        self.uid                = uid
        self.email              = email
        self.pseudo             = pseudo
        self.profilePicturePath = profilePicturePath
    }
    
    static let EMAIL_KEY = "email"
    static let PSEUDO_KEY = "pseudo"
    static let PROFILE_PICTURE_PATH_KEY = "profilePicturePath"
    
    static func parse(_ data : [String: Any], for id: String) -> FirestoreUser? {
        guard let email = data[FirestoreUser.EMAIL_KEY] as? String else { return nil }
        let firestoreUser = FirestoreUser(uid: id, email: email)
        if let pseudo = data[FirestoreUser.PSEUDO_KEY] as? String {
            firestoreUser.pseudo = pseudo
        }
        if let profilePicturePath = data[FirestoreUser.PROFILE_PICTURE_PATH_KEY] as? String {
            firestoreUser.profilePicturePath = profilePicturePath
        }
        return firestoreUser
    }
}
