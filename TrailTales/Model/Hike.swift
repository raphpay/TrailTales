//
//  Hike.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
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
    // TODO: Add multiple photo support
//    @Persisted var photos = List<Data>()
    @Persisted var durationInS: Double = 0.0
    @Persisted var date: Date?
    
    // MARK: - Initialization
    convenience init(name: String,
                     location: String,
                     distance: String,
                     difficulty: HikeDifficulty,
                     ownerId: String,
                     durationInS: Double,
                     date: Date? = nil) {
        self.init()
        self.name = name
        self.location = location
        self.distance = distance
        self.difficulty = difficulty
        self.ownerId = ownerId
        self.durationInS = durationInS
        self.date = date
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
    
    var badgeColor: Color {
        switch self {
        case .veryEasy:
            return .greenish
        case .easy:
            return .blueish
        case .medium:
            return .yellowish
        case .hard:
            return .brownish
        case .veryHard:
            return .red
        }
    }
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
