//
//  TopBarNav.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import SwiftUI

struct TopBarNav: View {
    
    @State private var showProfile = false
    
    var body: some View {
        VStack {
            HStack {
                TTRoundedButton(icon: SFSymbols.search.rawValue,
                                circleSize: 35, iconSize: 18,
                                foregroundColor: .gray, iconColor: .black)
                Spacer()
                Text("Trail Tales")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
                TTRoundedButton(icon: SFSymbols.person.rawValue,
                                circleSize: 35, iconSize: 20,
                                foregroundColor: .gray, iconColor: .black) {
                    showProfile = true
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .sheet(isPresented: $showProfile) {
            ProfileView()
        }
    }
}


struct TopBarNav_Previews: PreviewProvider {
    static var previews: some View {
        TopBarNav()
    }
}
