//
//  LoginView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 08/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Go Outdoor")
                Spacer()
                Group {
                    GOTextField(title: "Email",
                                placeholder: "Enter your email",
                                text: $email)
                    GOTextField(title: "Password",
                                placeholder: "Enter your password",
                                text: $password)
                }
                .padding(.horizontal)
                
                Spacer()
                
                GORoundedButton(title: "Login", isEnabled: .constant(false)) {
                    // login
                }
                HStack {
                    Text("Not a member ?")
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.secondaryBlue)
                            .bold()
                    }
                }
            }
            .padding()
            .navigationDestination(for: Bool.self) { showScreen in
                SignUpView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
