//
//  LoginView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 08/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Go Outdoor")
                Spacer()
                Group {
                    GOTextField(title: "Email",
                                placeholder: "Enter your email",
                                keyboardType: .emailAddress,
                                text: $viewModel.email)
                    .onChange(of: viewModel.email) { newValue in
                        viewModel.onNewEmailValue(newValue)
                    }
                    GOTextField(title: "Password",
                                placeholder: "Enter your password",
                                isSecured: true,
                                text: $viewModel.password)
                    .onChange(of: viewModel.password) { newValue in
                        viewModel.onNewPasswordValue(newValue)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                GORoundedButton(title: "Login", isEnabled: $viewModel.isLoginButtonEnabled) {
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
