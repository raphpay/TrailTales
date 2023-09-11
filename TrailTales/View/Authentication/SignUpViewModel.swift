//
//  SignUpViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isPasswordConfirmationValid: Bool = false
    
    @Published var isSignUpButtonEnabled: Bool = false
    
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
}

