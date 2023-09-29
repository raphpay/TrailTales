//
//  MockData.swift
//  TrailTales
//
//  Created by Raphaël Payet on 25/09/2023.
//

import Foundation

class MockData {
    static let hike = Hike(name: "Lac de Sainte-Anne", location: "Queyras", distance: "24", difficulty: .hard, ownerId: "MockID", durationInS: 7200.0, date: Date(timeIntervalSince1970: 1695300500))
    static let hikes = [
        Hike(name: "Lac de Sainte-Anne", location: "Queyras", distance: "24", difficulty: .hard, ownerId: "MockID", durationInS: 2179, date: Date(timeIntervalSince1970: 1663764500)),
        Hike(name: "Col de l'Ubaye", location: "Ubaye", distance: "32", difficulty: .veryHard, ownerId: "MockID2", durationInS: 1020)
    ]
    
    static let firestoreUser = FirestoreUser(uid: "id", email: "email@trailtales.com", pseudo: "Pseudonyme")
}
