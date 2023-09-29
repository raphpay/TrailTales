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
    
    // MARK: - Create    
    func create(_ user: LocalUser) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            if !realm.objects(LocalUser.self).contains(where: { $0.firebaseID == user.firebaseID }) {
                realm.add(user)
            }
        }
    }
    
    // MARK: - Read
    func getLocalUser(with id: String) -> LocalUser? {
        guard let realm = try? Realm() else { return nil }
        return realm.objects(LocalUser.self).first(where: { $0.firebaseID == id})
    }
    
    // MARK: - Update
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
    
    // MARK: - Delete
}
