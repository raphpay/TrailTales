//
//  TTTextField.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

struct TTTextField: View {
    var title: String
    var placeholder: String
    var isSecured: Bool = false
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            if isSecured {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(.roundedBorder)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

struct GOTextField_Previews: PreviewProvider {
    static var previews: some View {
        TTTextField(title: "Email", placeholder: "Enter your email", text: .constant(""))
    }
}

