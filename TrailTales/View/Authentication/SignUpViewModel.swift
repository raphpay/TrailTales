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
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isPasswordConfirmationValid: Bool = false
    @Published var isSignUpButtonEnabled: Bool = false
    @Published var showDashboard: Bool = false
    
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
    
    func signUp() async -> Bool {
        var isSignedIn = false
        
        do {
            let _ = try await Auth.auth().createUser(withEmail: email, password: password)
            isSignedIn = true
        } catch let error {
            print("Error signing up:", error)
        }
        
        return isSignedIn
    }
}

