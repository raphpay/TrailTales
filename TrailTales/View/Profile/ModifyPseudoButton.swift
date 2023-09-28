//
//  ModifyPseudoButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct ModifyPseudoButton: View {
    var userID: String
    @Binding var pseudo: String
    @Binding var isModifyingPseudo: Bool
    
    var body: some View {
        if isModifyingPseudo {
            Button {
                LocalUserManager.shared.updatePseudo(pseudo, for: userID)
                isModifyingPseudo = false
            } label: {
                Text("Save Pseudo")
            }
        } else {
            Button {
                isModifyingPseudo = true
            } label: {
                Text("Modify Pseudo")
            }
        }
    }
}

struct ModifyPseudoButton_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPseudoButton(userID: "ID", pseudo: .constant("Pseudo"), isModifyingPseudo: .constant(false))
    }
}
