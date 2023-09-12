//
//  SignUpView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Text("Go Outdoor")
            Spacer()
            Group {
                TTTextField(title: "Email",
                            placeholder: "Enter your email",
                            keyboardType: .emailAddress,
                            text: $viewModel.email)
                .onChange(of: viewModel.email) { newValue in
                    viewModel.onNewEmailValue(newValue)
                }
                TTTextField(title: "Password",
                            placeholder: "Enter your password",
                            isSecured: true,
                            text: $viewModel.password)
                .onChange(of: viewModel.password) { newValue in
                    viewModel.onNewPasswordValue(newValue)
                }
                TTTextField(title: "Password Confirmation",
                            placeholder: "Confirm your password",
                            isSecured: true,
                            text: $viewModel.passwordConfirmation)
                .onChange(of: viewModel.passwordConfirmation) { newValue in
                    viewModel.onNewPasswordConfirmationValue(newValue)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            TTButton(title: "Sign up", isEnabled: $viewModel.isSignUpButtonEnabled) {
                Task {
                    let result = await viewModel.signUp()
                    switch result {
                    case .success(let authDataResult):
                        authDataProvider.currentUser = authDataResult.user
                        authDataProvider.isLoggedIn = true
                    case .failure(let error):
                        viewModel.showAlert = true
                        viewModel.alertMessage = error.localizedDescription
                    }
                }
            }
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.showDashboard) {
            HikeListView()
        }
        .alert("An error occurred", isPresented: $viewModel.showAlert)  {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

