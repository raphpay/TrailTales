//
//  LocalUserFirestore.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import Foundation

final class LocalUserFirestore: Codable {
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
    
    static func parse(_ data : [String: Any], for id: String) -> LocalUserFirestore? {
        guard let email = data[LocalUserFirestore.EMAIL_KEY] as? String else { return nil }
        let localUser = LocalUserFirestore(uid: id, email: email)
        if let pseudo = data[LocalUserFirestore.PSEUDO_KEY] as? String {
            localUser.pseudo = pseudo
        }
        if let profilePicturePath = data[LocalUserFirestore.PROFILE_PICTURE_PATH_KEY] as? String {
            localUser.profilePicturePath = profilePicturePath
        }
        return localUser
    }
}
