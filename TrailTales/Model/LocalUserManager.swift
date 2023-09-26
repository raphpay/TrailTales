//
//  LocalUserManager.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import Foundation
import RealmSwift

final class LocalUserManager {
    static let shared = LocalUserManager()

    private init() {}
    
    func createLocalUser(firebaseID: String, emailAddress: String) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            if !realm.objects(LocalUser.self)
                .contains(where: { $0.firebaseID == firebaseID }) {
                let newUser = LocalUser(firebaseID: firebaseID, emailAddress: emailAddress)
                realm.add(newUser)
            }
        }
    }

    func deleteLocalUser() {
        guard let realm = try? Realm() else { return }
        if let existingUser = realm.objects(LocalUser.self).first {
            try? realm.write {
                realm.delete(existingUser)
            }
        }
    }
    
    func updatePseudo(_ pseudo: String, for userID: String) {
        guard let realm = try? Realm() else { return }
        if let existingUser = realm.objects(LocalUser.self).first(where: { $0.firebaseID == userID}) {
            try? realm.write {
                existingUser.pseudo = pseudo
            }
        }
    }
    
    func updateProfilePicture(_ data: Data, for userID: String) {
        guard let realm = try? Realm() else { return }
        if let existingUser = realm.objects(LocalUser.self).first(where: { $0.firebaseID == userID}) {
            try? realm.write {
                existingUser.profilePicture = data
            }
        }
    }
    
    func getLocalUser(with id: String) -> LocalUser? {
        guard let realm = try? Realm() else { return nil }
        return realm.objects(LocalUser.self).first(where: { $0.firebaseID == id})
    }
}
