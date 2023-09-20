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
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @StateObject private var viewModel = HikeListViewModel()
    
    var body: some View {
        VStack {
            Button {
                viewModel.showHikeCreation = true
            } label: {
                Text("Log a hike")
            }
            List {
                ForEach(viewModel.filteredHikes) { hike in
                    NavigationLink {
                        HikeDetails(hike: hike)
                    } label: {
                        Text(hike.name)
                    }
                }
                .onDelete(perform: viewModel.deleteHike)
            }
        }
        .onAppear {
            if let userID = authDataProvider.currentUser?.uid {
                viewModel.fetchAndFilterHikes(userID: userID)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showHikeCreation) {
            AddHikeView(filteredHikes: $viewModel.filteredHikes)
        }
        .navigationTitle("Hike lists")
        .toolbar {
            Button {
                Task {
                    let result = await viewModel.signOut()
                    switch result {
                    case .success( _):
                        authDataProvider.isLoggedIn = false
                    case .failure(let failure):
                        // TODO: Handle error
                        print("failure", failure)
                    }
                }
            } label: {
                Image(systemName: SFSymbols.logOut.rawValue)
            }
        }
    }
}

struct HikeListView_Previews: PreviewProvider {
    static var previews: some View {
        HikeListView()
    }
}
