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
    
    @Published var searchText: String = "" {
        didSet {
            filterHikes()
        }
    }
    
    var userID: String = "" {
        didSet {
            filterHikes()
        }
    }
    
    init() {
        // Initialize filteredHikes with all hikes when the view model is created
        filteredHikes = Array(hikes)
    }
    
    func setUserID(_ userID: String) {
        self.userID = userID
    }
    
    func filterHikes() {
        if searchText.isEmpty {
            // If the search text is empty, show hikes of the specified user
            filteredHikes = hikes.filter { hike in
                return hike.ownerId == userID
            }
        } else {
            // Filter hikes based on the search text
            filteredHikes = hikes.filter { hike in
                // You can customize the filter criteria as needed
                return hike.name.localizedCaseInsensitiveContains(searchText)
            }
            
            // Check if no matches were found and set filteredHikes to all hikes
            if filteredHikes.isEmpty {
                filteredHikes = hikes.filter { hike in
                    return hike.ownerId == userID
                }
            }
        }
    }
}
