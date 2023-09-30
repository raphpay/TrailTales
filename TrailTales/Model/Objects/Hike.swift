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
    @Persisted var story: String = "" // This is the description of the hike. The term description is already taken by Realm for an object
    
    // MARK: - Initialization
    convenience init(name: String,
                     location: String,
                     distance: String,
                     difficulty: HikeDifficulty,
                     ownerId: String,
                     durationInS: Double,
                     date: Date? = nil,
                     story: String = "") {
        self.init()
        self.name = name
        self.location = location
        self.distance = distance
        self.difficulty = difficulty
        self.ownerId = ownerId
        self.durationInS = durationInS
        self.date = date
        self.story = story
    }
}

enum HikeDifficulty: String, PersistableEnum, Equatable, CaseIterable {
    case veryEasy, easy, medium, hard, veryHard
    
    var label: String {
        switch self {
        case .veryEasy:
            return NSLocalizedString("Very Easy", comment: "Very Easy Difficulty")
        case .easy:
            return NSLocalizedString("Easy", comment: "Easy Difficulty")
        case .medium:
            return NSLocalizedString("Medium", comment: "Medium Difficulty")
        case .hard:
            return NSLocalizedString("Hard", comment: "Hard Difficulty")
        case .veryHard:
            return NSLocalizedString("Very Hard", comment: "Very Hard Difficulty")
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
