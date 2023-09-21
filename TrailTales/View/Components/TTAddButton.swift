//
//  TTAddButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import SwiftUI

struct TTAddButton: View {
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                TTRoundedButton(icon: SFSymbols.plus.rawValue) {
                    action()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TTAddButton_Previews: PreviewProvider {
    static var previews: some View {
        TTAddButton(action: {})
    }
}
