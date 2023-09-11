//
//  SignUpView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var isLoggedIn: Bool
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
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
                GOTextField(title: "Password Confirmation",
                            placeholder: "Confirm your password",
                            isSecured: true,
                            text: $viewModel.passwordConfirmation)
                .onChange(of: viewModel.passwordConfirmation) { newValue in
                    viewModel.onNewPasswordConfirmationValue(newValue)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            GORoundedButton(title: "Sign up", isEnabled: $viewModel.isSignUpButtonEnabled) {
                Task {
                    isLoggedIn = await viewModel.signUp()
                }
            }
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.showDashboard) {
            DashboardView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoggedIn: .constant(false))
    }
}

