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
        VStack {
            if isUpdating {
                TTTextField(title: "Name", placeholder: "Enter a new name", text: $hike.name)
                TTTextField(title: "Location", placeholder: "Enter a new location", text: $hike.location)
                TTTextField(title: "Distance", placeholder: "Enter a new location", keyboardType: .decimalPad, text: $hike.distance)
                TTTextField(title: "Location", placeholder: "Enter a new location", text: $hike.difficulty)
                Button {
                    isUpdating = false
                } label: {
                    Text("Save")
                }
            } else {
                Text(hike.name)
                Text(hike.location)
                Text("\(hike.distance)km")
                Text(hike.difficulty)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hike.photos, id: \.self) { photoData in
                        if let uiImage = UIImage(data: photoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
        .toolbar {
            Button {
                isUpdating = true
            } label: {
                Image(systemName: SFSymbols.modify.rawValue)
            }
        }
    }
}

struct HikeDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetails(hike: MockData.hike)
    }
}

