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
    
    func signUp(completion: @escaping (_ isSignedIn: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                // Handle login error (show alert, etc.)
                print("Login error: \(error.localizedDescription)")
                completion(false)
            } else {
                // Login successful, navigate to the main app screen
                // You can use NavigationLink or other navigation methods here
                print("login successful")
                self.showDashboard = true
                completion(true)
            }
        }
    }
}

