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
    @Persisted var pseudo: String = ""
    @Persisted var emailAddress: String = ""
    @Persisted var profilePicture: Data?
    // TODO: Link the hikes ?
}
