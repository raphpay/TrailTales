//
//  HikeDetails.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import RealmSwift

struct HikeDetails: View {
    
    @ObservedRealmObject var hike: Hike
    @State private var isUpdating = false
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return ZStack {
            if let coverData = hike.coverPhoto,
               let coverImage = UIImage(data: coverData) {
                ClearBackgroundUIImage(uiImage: coverImage)
            } else {
                ClearBackgroundImage(image: AssetsImages.BackgroundImage.rawValue)
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(hike.name)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        DifficultyBadge(difficulty: hike.difficulty)
                    }
                    Text(hike.location)
                        .font(.system(size: 20, weight: .regular))
                    if let hikeDate = hike.date {
                        Text(dateFormatter.string(from: hikeDate))
                            .font(.system(size: 14, weight: .light))
                    }
                    
                    Label("\(hike.distance)km", systemImage: SFSymbols.walk.rawValue)
                    Label(hike.durationInS.formatDuration(), systemImage: SFSymbols.duration.rawValue)
                    Text(hike.story)
                }
                .fullWidth()
                .padding()
            }
        }
        .onAppear {
            print(hike)
        }
    }
}

struct HikeDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetails(hike: MockData.hike)
    }
}

