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
                        HStack(alignment: .center) {
                            if let coverData = hike.coverPhoto,
                               let coverImage = UIImage(data: coverData) {
                                Image(uiImage: coverImage)
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .cornerRadius(10)
                                    .clipped()
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .fill(.black)
                                    .frame(width: 75, height: 75)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(hike.name)
                                    .font(.system(size: 20, weight: .medium))
                                Text(hike.location)
                                    .font(.system(size: 16, weight: .regular))
                                Text("Date of the hike")
                                    .font(.system(size: 14, weight: .light))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(hike.difficulty.label)
                                    .font(.system(size: 14, weight: .light))
                                Text("Hike duration")
                                    .font(.system(size: 14, weight: .light))
                            }
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blueish)
                        )
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
