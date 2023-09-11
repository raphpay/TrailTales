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
    @Persisted var name: String = ""
    @Persisted var location: String = ""
    @Persisted var distance: Double = 0.0
    @Persisted var difficulty: String = ""
    
    // MARK: - Initialization
    convenience init(name: String, location: String, distance: Double, difficulty: String) {
        self.init()
        self.name = name
        self.location = location
        self.distance = distance
        self.difficulty = difficulty
    }
}

/// Represents a collection of hikes.
final class HikesGroup: Object, ObjectKeyIdentifiable {
    /// The unique ID of the HikesGroup. `primaryKey: true` declares the
    /// _id member as the primary key to the realm.
    @Persisted(primaryKey: true) var _id: ObjectId
    /// The collection of Items in this group.
    @Persisted var items = RealmSwift.List<HikesGroup>()
}
