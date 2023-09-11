//
//  SignUpViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseAuth

final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var alertMessage: String = ""
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isPasswordConfirmationValid: Bool = false
    @Published var isSignUpButtonEnabled: Bool = false
    @Published var showDashboard: Bool = false
    @Published var showAlert: Bool = false
    
    func onNewEmailValue(_ email: String) {
        isEmailValid = email.contains("@")
        checkButtonActivation()
    }

    func onNewPasswordValue(_ password: String) {
        isPasswordValid = password.count >= 8
        checkButtonActivation()
    }
    
    func onNewPasswordConfirmationValue(_ passwordConfirmation: String) {
        isPasswordConfirmationValid = passwordConfirmation == password
        checkButtonActivation()
    }
    
    func checkButtonActivation() {
        isSignUpButtonEnabled = isEmailValid && isPasswordValid && isPasswordConfirmationValid
    }
    
    func signUp() async -> Result<Bool, Error> {
        do {
            let _ = try await Auth.auth().createUser(withEmail: email, password: password)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}

