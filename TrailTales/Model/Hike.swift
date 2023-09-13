//
//  Hike.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import Foundation
import RealmSwift

final class Hike: Object, ObjectKeyIdentifiable {
    // MARK: - Properties
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var ownerId = ""
    @Persisted var name: String = ""
    @Persisted var location: String = ""
    @Persisted var distance: String = ""
    @Persisted var difficulty: String = ""
    @Persisted var photos = List<Data>()
    
    // MARK: - Initialization
    convenience init(name: String, location: String, distance: String, difficulty: String, ownerId: String) {
        self.init()
        self.name = name
        self.location = location
        self.distance = distance
        self.difficulty = difficulty
        self.ownerId = ownerId
    }
}

class MockData {
    static let hike = Hike(name: "Lac de Sainte-Anne", location: "Queyras", distance: "24", difficulty: "Hard", ownerId: "MockID")
}

/// Represents a collection of hikes.
final class HikesGroup: Object, ObjectKeyIdentifiable {
    /// The unique ID of the HikesGroup. `primaryKey: true` declares the
    /// _id member as the primary key to the realm.
    @Persisted(primaryKey: true) var _id: ObjectId
    /// The collection of Items in this group.
    @Persisted var items = RealmSwift.List<HikesGroup>()
    /// Store the user.id as the ownerId so you can query for the user's objects with Flexible Sync
    @Persisted var ownerId = ""
}
