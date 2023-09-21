//
//  MainView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @State private var filteredHikes: [Hike] = []
    @ObservedResults(Hike.self) var hikes
    
    var body: some View {
        VStack {
            if filteredHikes.isEmpty {
                EmptyMainView()
            } else {
                HikeListView(hikes: $filteredHikes)
            }
        }
            .onAppear {
                if let userID = authDataProvider.currentUser?.uid {
                    fetchAndFilterHikes(userID: userID)
                }
            }
    }
    
    func fetchAndFilterHikes(userID: String) {
        filteredHikes = hikes.filter { hike in
            return hike.ownerId == userID
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
