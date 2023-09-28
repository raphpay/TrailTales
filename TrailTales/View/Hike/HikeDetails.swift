//
//  HikeDetails.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import RealmSwift
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.85 // 702/844
    case middle = 0.68 // 325/844
}

struct HikeDetails: View {
    
    @ObservedRealmObject var hike: Hike
    @State private var isUpdating = false
    @State var bottomSheetPosition: BottomSheetPosition = .top
    
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var ownerId = ""
//    @Persisted var name: String = ""
//    @Persisted var location: String = ""
//    @Persisted var distance: String = ""
//    @Persisted var difficulty: HikeDifficulty = .medium
//    @Persisted var coverPhoto: Data?
////    @Persisted var photos = List<Data>()
//    @Persisted var durationInS: Double = 0.0
//    @Persisted var date: Date?
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return ZStack {
            if let coverData = hike.coverPhoto,
               let coverImage = UIImage(data: coverData) {
                ClearBackgroundUIImage(uiImage: coverImage)
            } else {
                BackgroundImage()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.system(size: 20, weight: .bold))
                    Text(hike.location)
                        .font(.system(size: 20, weight: .regular))
                    if let hikeDate = hike.date {
                        Text(dateFormatter.string(from: hikeDate))
                            .font(.system(size: 14, weight: .light))
                    }
                    
                    Label("\(hike.distance)km", systemImage: SFSymbols.walk.rawValue)
                    Label(hike.durationInS.formatDuration(), systemImage: SFSymbols.duration.rawValue)
                }
                .fullWidth()
                .padding()
            }
        }
    }
    
    var coverPhoto: some View {
        VStack {
            if let coverData = hike.coverPhoto,
               let coverImage = UIImage(data: coverData) {
                Image(uiImage: coverImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
            } else {
                Rectangle()
                    .fill(.gray)
                    .frame(height: 300)
            }
        }
    }
}

struct HikeDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetails(hike: MockData.hike)
    }
}

