//
//  HikeCardDetails.swift
//  TrailTales
//
//  Created by Raphaël Payet on 18/09/2023.
//

import SwiftUI
import RealmSwift

struct HikeCardDetails: View {
    
    @ObservedRealmObject var hike: Hike
    
    var body: some View {
        VStack {
            HStack {
                Text(hike.name)
                    .font(.title)
            }
        }
    }
}

struct HikeCardDetails_Previews: PreviewProvider {
    static var previews: some View {
        HikeCardDetails(hike: MockData.hike)
    }
}
