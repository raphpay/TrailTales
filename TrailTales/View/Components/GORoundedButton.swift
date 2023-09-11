//
//  GORoundedButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

// TODO: Change name according to the app name
struct GORoundedButton: View {
    
    var title: String
    var color: Color = .primaryGreen
    @Binding var isEnabled: Bool
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isEnabled ? color : .gray)
                    .frame(height: 50)
                Text(title)
                    .foregroundColor(.primary)
            }
        }
        .disabled(!isEnabled)
    }
}

struct GORoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        GORoundedButton(title: "Login", isEnabled: .constant(true), action: {})
    }
}

