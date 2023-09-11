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
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isLoginButtonEnabled: Bool = false
    @Published var showSignUpView: Bool = false
    @Published var showDashboard: Bool = false
    
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
    
//    func login(completionHandler: @escaping (_ isLoggedIn: Bool) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                // Handle login error (show alert, etc.)
//                print("Login error: \(error.localizedDescription)")
//                completionHandler(false)
//            } else {
//                // Login successful, navigate to the main app screen
//                // You can use NavigationLink or other navigation methods here
//                completionHandler(true)
//            }
//        }
//    }
    
    func login() async -> Bool {
        var isLoggedIn = false
        do {
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            isLoggedIn = true
        } catch let error {
            print(error)
        }
        return isLoggedIn
    }
}
