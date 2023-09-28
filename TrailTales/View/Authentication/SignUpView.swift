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
        ZStack {
            ClearBackgroundImage(image: AssetsImages.LoginBackground.rawValue)
            VStack {
                Logo()
                Spacer()
                Group {
                    TTTextField(title: NSLocalizedString("Email", comment: "Email comment"),
                                placeholder: NSLocalizedString("Enter your email", comment: "Enter your email comment"),
                                keyboardType: .emailAddress,
                                text: $viewModel.email)
                    .onChange(of: viewModel.email) { newValue in
                        viewModel.onNewEmailValue(newValue)
                    }
                    TTTextField(title: NSLocalizedString("Password", comment: "Password comment"),
                                placeholder: NSLocalizedString("Enter your password", comment: "Enter your password comment"),
                                isSecured: true,
                                text: $viewModel.password)
                    .onChange(of: viewModel.password) { newValue in
                        viewModel.onNewPasswordValue(newValue)
                    }
                    TTTextField(title: NSLocalizedString("Password Confirmation", comment: "Password Confirmation comment"),
                                placeholder: NSLocalizedString("Confirm your password", comment: "Confirm your password comment"),
                                isSecured: true,
                                text: $viewModel.passwordConfirmation)
                    .onChange(of: viewModel.passwordConfirmation) { newValue in
                        viewModel.onNewPasswordConfirmationValue(newValue)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                TTButton(title: NSLocalizedString("Sign up", comment: "Sign up comment"),
                         isEnabled: $viewModel.isSignUpButtonEnabled) {
                    Task {
                        let result = await viewModel.signUp()
                        switch result {
                        case .success(let authDataResult):
                            authDataProvider.login(authDataResult.user)
                        case .failure(let error):
                            viewModel.showAlert = true
                            viewModel.alertMessage = error.localizedDescription
                        }
                    }
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $viewModel.showDashboard) {
            MainView()
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

