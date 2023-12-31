//
//  LoginViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isLoginButtonEnabled: Bool = false
    @Published var showSignUpView: Bool = false
    @Published var showDashboard: Bool = false
    @Published var showAlert: Bool = false

    
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
    
    func login() async -> Result<AuthDataResult, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(result)
        } catch let error {
            return .failure(error)
        }
    }
}
