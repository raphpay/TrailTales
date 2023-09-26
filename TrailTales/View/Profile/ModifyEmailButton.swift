//
//  ModifyEmailButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct ModifyEmailButton: View {
    @Binding var isModifyingEmail: Bool
    
    var body: some View {
        if isModifyingEmail {
            Button {
                isModifyingEmail = false
            } label: {
                Text("Save Email")
            }
        } else {
            Button {
                isModifyingEmail = true
            } label: {
                Text("Modify Email")
            }
        }
    }
}

struct ModifyEmailButton_Previews: PreviewProvider {
    static var previews: some View {
        ModifyEmailButton(isModifyingEmail: .constant(false))
    }
}
