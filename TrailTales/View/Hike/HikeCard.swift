//
//  HikeCard.swift
//  TrailTales
//
//  Created by Raphaël Payet on 22/09/2023.
//

import SwiftUI

struct HikeCard: View {
    
    var hike: Hike
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return HStack(alignment: .center) {
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
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(hike.location)
                    .font(.system(size: 16, weight: .regular))
                if let hikeDate = hike.date {
                    Text(dateFormatter.string(from: hikeDate))
                        .font(.system(size: 14, weight: .light))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                DifficultyBadge(difficulty: hike.difficulty)
                Text("\(hike.durationInS.formatDuration())")
                    .font(.system(size: 14, weight: .light))
            }
            .padding(.trailing, 8)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blueish)
        )
    }
}

struct HikeCard_Previews: PreviewProvider {
    static var previews: some View {
        HikeCard(hike: MockData.hike)
    }
}
