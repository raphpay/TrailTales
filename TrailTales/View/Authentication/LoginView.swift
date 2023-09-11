//
//  LoginView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 08/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
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
                    Task {
                        let result = await viewModel.login()
                        switch result {
                        case .success(let successValue):
                            authDataProvider.isLoggedIn = successValue
                        case .failure(let error):
                            viewModel.showAlert = true
                            viewModel.alertMessage = error.localizedDescription
                        }
                    }
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
            .navigationDestination(isPresented: $viewModel.showSignUpView) {
                SignUpView()
            }
            .navigationDestination(isPresented: $viewModel.showDashboard) {
                HikeListView()
            }
            .alert("An error occured", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
