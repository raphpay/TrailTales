//
//  HikeListView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import SwiftUI

struct HikeListView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @State private var showAddHikeView = false
    @State private var showSearchBar = false
    
    
    var body: some View {
        ZStack {
            BackgroundImage(blurRadius: 10)
            
            VStack {
                TopBarNav(showSearchBar: $showSearchBar)
                
                VStack {
                    if showSearchBar {
                        TextField("Search for a hike", text: $mainViewModel.searchText)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom, 30)
                    }
                    
                    HStack {
                        Text("Your hikes:")
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                    }
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(mainViewModel.filteredHikes) { hike in
                            NavigationLink {
                                HikeDetails(hike: hike)
                            } label: {
                                HikeCard(hike: hike)
                                    .foregroundColor(.primary)
                            }

                        }
                    }
                }
                .offset(y: showSearchBar ? 20.0 : 0.0)
            }
            .padding(.horizontal)
            
            TTAddButton {
                showAddHikeView = true
            }
        }
        .fullScreenCover(isPresented: $showAddHikeView) {
            AddHikeView()
        }
    }
}

struct HikeListView_Previews: PreviewProvider {
    static let mainViewModel = MainViewModel()
    
    static var previews: some View {
        HikeListView()
            .environmentObject(mainViewModel)
    }
}
