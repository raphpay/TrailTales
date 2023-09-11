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
    
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    @State private var isLoginButtonEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Go Outdoor")
                Spacer()
                Group {
                    GOTextField(title: "Email",
                                placeholder: "Enter your email",
                                text: $email)
                    .onChange(of: email) { newValue in
                        onNewEmailValue(newValue)
                    }
                    GOTextField(title: "Password",
                                placeholder: "Enter your password",
                                text: $password)
                    .onChange(of: password) { newValue in
                        onNewPasswordValue(newValue)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                GORoundedButton(title: "Login", isEnabled: $isLoginButtonEnabled) {
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
    
    func onNewEmailValue(_ email: String) {
        isEmailValid = email.contains("@")
        checkButtonActivation()
    }

    func onNewPasswordValue(_ password: String) {
        isPasswordValid = !password.isEmpty // We just need one character to enable the button
        checkButtonActivation()
    }
    
    func checkButtonActivation() {
        isLoginButtonEnabled = isEmailValid && isPasswordValid
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
