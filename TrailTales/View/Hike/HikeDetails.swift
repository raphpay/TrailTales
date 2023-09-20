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
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            StickyHeader() {
                // MARK: - Cover photo
                coverPhoto
            }
            

            // MARK: - Hike details
            VStack(alignment: .leading) {
                Text(hike.name)
                    .font(.title)
                    .bold()
                Text(hike.location)
                    .font(.headline)
            }
            .fullWidth()
            .padding(.top)
            .padding(.horizontal)
            
            // MARK: - Photos
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hike.photos, id: \.self) { photoData in
                        if let image = UIImage(data: photoData) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 150, height: 150)
                        } 
                    }
                }
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

extension View {
    func fullWidth(_ alignment: Alignment = .leading) -> some View {
        self
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: alignment
            )
    }
}

struct HikeDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetails(hike: MockData.hike)
    }
}

