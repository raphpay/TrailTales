//
//  MainViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import Foundation
import RealmSwift

final class MainViewModel: ObservableObject {
    @Published var filteredHikes: [Hike] = []
    @ObservedResults(Hike.self) var hikes
    
    func fetchAndFilterHikes(userID: String) {
        filteredHikes = hikes.filter { hike in
            return hike.ownerId == userID
        }
    }
}
