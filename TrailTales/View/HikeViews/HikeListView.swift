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
    
    @Binding var isLoggedIn: Bool
    @State private var userEmail: String = ""
    @ObservedResults(Hike.self) var hikes
    @State private var showHikeCreation = false
    
    var body: some View {
        VStack {
            Button {
                showHikeCreation = true
            } label: {
                Text("Log a hike")
            }
            List {
                ForEach(hikes) { hike in
                    NavigationLink {
                        HikeDetails(hike: hike)
                    } label: {
                        Text(hike.name)
                    }
                }
                .onDelete(perform: $hikes.remove(atOffsets:))
            }
        }
        .fullScreenCover(isPresented: $showHikeCreation) {
            AddHikeView()
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
            isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct HikeListView_Previews: PreviewProvider {
    static var previews: some View {
        HikeListView(isLoggedIn: .constant(true))
    }
}
