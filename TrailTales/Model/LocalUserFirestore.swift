//
//  LocalUserFirestore.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import Foundation

final class LocalUserFirestore {
    var uid: String = ""
    var pseudo: String = ""
    var profilePicture: Data?
    
    // MARK: - Initialization
    convenience init(uid: String, pseudo: String = "", profilePicture: Data? = nil) {
        self.init()
        self.uid            = uid
        self.pseudo         = pseudo
        self.profilePicture = profilePicture
    }
}
