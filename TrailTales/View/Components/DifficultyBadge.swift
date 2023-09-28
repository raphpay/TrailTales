//
//  DifficultyBadge.swift
//  TrailTales
//
//  Created by Raphaël Payet on 28/09/2023.
//

import SwiftUI

struct DifficultyBadge: View {
    
    var difficulty: HikeDifficulty
    
    var body: some View {
        Text(difficulty.label)
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .light))
            .padding()
            .background(
                Capsule()
                    .frame(width: 80, height: 30)
                    .foregroundStyle(difficulty.badgeColor)
                    .shadow(radius: 10)
            )
    }
}

#Preview {
    DifficultyBadge(difficulty: .hard)
}
