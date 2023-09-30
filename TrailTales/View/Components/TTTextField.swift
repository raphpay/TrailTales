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
    var disableAutoCorrection: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(title, comment: "\(title) comment"))
            if isSecured {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(.roundedBorder)
            } else {
                TextField(NSLocalizedString(placeholder, comment: "\(placeholder) comment"),
                          text: $text, axis: .vertical)
                    .keyboardType(keyboardType)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled(disableAutoCorrection)
            }
        }
        .padding(.top, 8)
    }
}

struct GOTextField_Previews: PreviewProvider {
    static var previews: some View {
        TTTextField(title: "Email", placeholder: "Enter your email", text: .constant(""))
    }
}

