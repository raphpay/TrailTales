//
//  MainView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        VStack {
            if mainViewModel.filteredHikes.isEmpty {
                EmptyMainView()
            } else {
                HikeListView()
            }
        }
        .environmentObject(mainViewModel)
        .onAppear {
            if let userID = authDataProvider.currentUser?.uid {
                mainViewModel.setUserID(userID)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
