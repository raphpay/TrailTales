//
//  UserEmailView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct UserEmailView: View {
    @Binding var email: String
    @Binding var isModifyingEmail: Bool
    
    var body: some View {
        VStack {
            if isModifyingEmail {
               TTTextField(title: "Email", placeholder: "Enter your email", text: $email)
            } else {
                HStack {
                    Spacer()
                    Text(email)
                        .font(.subheadline)
                        .bold()
                        .padding(.top, 10)
                    Spacer()
                }
            }
        }
    }
}

struct UserEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UserEmailView(email: .constant(""), isModifyingEmail: .constant(false))
    }
}
