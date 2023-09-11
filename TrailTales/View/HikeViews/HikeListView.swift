//
//  HikeListView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseAuth
import RealmSwift

struct HikeListView: View {
    
    @State private var userEmail: String = ""
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @ObservedResults(Hike.self) var hikes
    @State private var showHikeCreation = false
    
    // Define a local property to hold the filtered hikes
    @State private var filteredHikes: [Hike] = []
    
    var body: some View {
        VStack {
            Button {
                showHikeCreation = true
            } label: {
                Text("Log a hike")
            }
            List {
                ForEach(filteredHikes) { hike in
                    NavigationLink {
                        HikeDetails(hike: hike)
                    } label: {
                        Text(hike.name)
                    }
                }
                .onDelete(perform: deleteHike)
            }
        }
        .onAppear {
            fetchAndFilterHikes()
        }
        .fullScreenCover(isPresented: $showHikeCreation) {
            AddHikeView(filteredHikes: $filteredHikes)
        }
        .navigationTitle("Hello")
        .toolbar {
            Button {
                signOut()
            } label: {
                Image(systemName: SFSymbols.logOut.rawValue)
            }
        }
    }
    
    func getCurrentUser() {
        if let user = Auth.auth().currentUser,
           let mail = user.email {
          userEmail = mail
        } else {
          // No user is signed in.
          // ...
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            authDataProvider.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // Function to fetch and filter hikes
    func fetchAndFilterHikes() {
        // Use the authDataProvider to get the user's ID
        if let currentUserUid = authDataProvider.currentUser?.uid {
            // Assuming 'hikes' is your entire list of hikes
            filteredHikes = hikes.filter { hike in
                return hike.ownerId == currentUserUid
            }
        }
    }
    
    func deleteHike(at offsets: IndexSet) {
        $hikes.remove(atOffsets: offsets)
        filteredHikes.remove(atOffsets: offsets)
        
    }
}

struct HikeListView_Previews: PreviewProvider {
    static var previews: some View {
        HikeListView()
    }
}
