//
//  TTButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

// TODO: Change name according to the app name
struct TTButton: View {
    
    var title: String
    var color: Color = .greenish
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
                Text(NSLocalizedString(title, comment: "\(title) comment"))
                    .foregroundColor(.primary)
            }
        }
        .disabled(!isEnabled)
    }
}

struct GORoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        TTButton(title: "Login", isEnabled: .constant(true), action: {})
    }
}

