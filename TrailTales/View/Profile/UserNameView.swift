//
//  UserNameView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct UserNameView: View {
//    var user: LocalUser
    @Binding var pseudo: String
    @Binding var isModifyingPseudo: Bool

    var body: some View {
        VStack {
            if !isModifyingPseudo {
                HStack {
                    Spacer()
                    Text(pseudo)
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    Spacer()
                }
            } else if isModifyingPseudo {
                TTTextField(title: "Pseudo", placeholder: "Enter a pseudo", text: $pseudo)
                    .padding(.top, 10)
            }
        }
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView(pseudo: .constant(""), isModifyingPseudo: .constant(false))
    }
}
