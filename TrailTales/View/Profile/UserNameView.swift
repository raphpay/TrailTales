//
//  UserNameView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct UserNameView: View {
    var user: LocalUser
    @Binding var pseudo: String
    @Binding var isModifyingPseudo: Bool

    var body: some View {
        VStack {
            if !isModifyingPseudo {
                HStack {
                    Spacer()
                    Text(user.pseudo)
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    Spacer()
                }
            } else if isModifyingPseudo || user.pseudo.isEmpty {
                TTTextField(title: "Pseudo", placeholder: "Enter a pseudo", text: $pseudo)
                    .padding(.top, 10)
                    .onAppear {
                        pseudo = user.pseudo
                    }
            }
        }
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView(user: MockData.localUser, pseudo: .constant(""), isModifyingPseudo: .constant(false))
    }
}
