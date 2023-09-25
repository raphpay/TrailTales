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
    
    var body: some View {
        ZStack {
            BackgroundImage(blurRadius: 10)
            TopBarNav()
            
            VStack {
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
            .padding(.top, 70)
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
    static var previews: some View {
        HikeListView()
    }
}
