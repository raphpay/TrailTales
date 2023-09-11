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
    
    var body: some View {
        VStack {
            Text(hike.name)
            Text(hike.location)
            Text("\(hike.distance)km")
            Text(hike.difficulty)
        }
    }
}

struct HikeDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetails(hike: MockHike.sample)
    }
}

