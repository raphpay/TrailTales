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
    var profilePicture: Data?
    
    // MARK: - Initialization
    convenience init(uid: String, email: String, pseudo: String = "", profilePicture: Data? = nil) {
        self.init()
        self.uid            = uid
        self.email          = email
        self.pseudo         = pseudo
        self.profilePicture = profilePicture
    }
    
    static func parse(_ data : [String: Any], for id: String) -> LocalUserFirestore? {
        guard let email = data["email"] as? String else { return nil }
        let localUser = LocalUserFirestore(uid: id, email: email)
        if let pseudo = data["pseudo"] as? String {
            localUser.pseudo = pseudo
        }
        if let profilePicture = data["profilePicture"] as? Data {
            localUser.profilePicture = profilePicture
        }
        return localUser
    }
}
