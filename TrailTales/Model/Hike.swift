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
    @Persisted var difficulty: HikeDifficulty = .medium
    @Persisted var coverPhoto: Data?
    @Persisted var photos = List<Data>()
    // TODO: Add duration, and hike date
    
    // MARK: - Initialization
    convenience init(name: String, location: String, distance: String, difficulty: HikeDifficulty, ownerId: String) {
        self.init()
        self.name = name
        self.location = location
        self.distance = distance
        self.difficulty = difficulty
        self.ownerId = ownerId
    }
}

enum HikeDifficulty: String, PersistableEnum, Equatable, CaseIterable {
    case veryEasy, easy, medium, hard, veryHard
    
    var label: String {
        switch self {
        case .veryEasy:
            return "Very Easy"
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        case .veryHard:
            return "Very Hard"
        }
    }
}

class MockData {
    static let hike = Hike(name: "Lac de Sainte-Anne", location: "Queyras", distance: "24", difficulty: .hard, ownerId: "MockID")
    static let hikes = [
        Hike(name: "Lac de Sainte-Anne", location: "Queyras", distance: "24", difficulty: .hard, ownerId: "MockID"),
        Hike(name: "Col de l'Ubaye", location: "Ubaye", distance: "32", difficulty: .veryHard, ownerId: "MockID2")
    ]
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
