//
//  HikeListViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import Foundation
import FirebaseAuth
import RealmSwift

final class HikeListViewModel: ObservableObject {
    @Published var showHikeCreation = false
    @Published var filteredHikes: [Hike] = []
    
    @ObservedResults(Hike.self) var hikes
    
    func signOut() async -> Result<Bool, Error>{
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            return .success(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return .failure(signOutError)
        }
    }
    
    func fetchAndFilterHikes(userID: String) {
        filteredHikes = hikes.filter { hike in
            return hike.ownerId == userID
        }
    }
    
    func deleteHike(at offsets: IndexSet) {
        $hikes.remove(atOffsets: offsets)
        filteredHikes.remove(atOffsets: offsets)
        
    }
}
