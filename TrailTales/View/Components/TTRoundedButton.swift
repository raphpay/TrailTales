//
//  TTRoundedButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 20/09/2023.
//

import SwiftUI

struct TTRoundedButton: View {
    
    var icon: String
    var circleSize: CGFloat = 56
    var iconSize: CGFloat = 25
    var foregroundColor: Color = .brownish
    var iconColor: Color = .white
    var action: () -> Void = {}
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: circleSize)
                .foregroundColor(foregroundColor)
            Image(systemName: icon)
                .resizable()
                .foregroundColor(iconColor)
                .frame(width: iconSize, height: iconSize)
        }
        .shadow(radius: 10)
    }
}


struct TTRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        TTRoundedButton(icon: SFSymbols.plus.rawValue)
    }
}
