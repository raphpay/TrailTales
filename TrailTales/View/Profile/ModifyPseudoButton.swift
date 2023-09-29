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
        Button {
            isModifyingPseudo ? savePseudo() : modifyPseudo()
        } label: {
            Text(isModifyingPseudo ? "Save Pseudo" : "Modify Pseudo")
        }
    }
    
    func modifyPseudo() {
        withAnimation {
            isModifyingPseudo = true
        }
    }
    
    func savePseudo() {
        withAnimation {
            isModifyingPseudo = false
        }
        FirestoreManager.shared.updatePseudo(pseudo, for: userID)
    }
}

struct ModifyPseudoButton_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPseudoButton(userID: "ID", pseudo: .constant("Pseudo"), isModifyingPseudo: .constant(false))
    }
}
