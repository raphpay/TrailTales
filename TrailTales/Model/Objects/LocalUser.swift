//
//  User.swift
//  TrailTales
//
//  Created by Raphaël Payet on 25/09/2023.
//

import Foundation
import RealmSwift

final class LocalUser: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var firebaseID: String = ""
    @Persisted var emailAddress: String = ""
    @Persisted var pseudo: String = ""
    @Persisted var profilePicture: Data?
    @Persisted var profilePicturePath: String?
    // TODO: Link the hikes ?
    
    // MARK: - Initialization
    convenience init(firebaseID: String, emailAddress: String, pseudo: String = "",
                     profilePicture: Data? = nil, profilePicturePath: String? = nil) {
        self.init()
        self.firebaseID = firebaseID
        self.emailAddress = emailAddress
        self.pseudo = pseudo
        self.profilePicture = profilePicture
        self.profilePicturePath = profilePicturePath
    }
}
