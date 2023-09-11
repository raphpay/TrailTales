//
//  WelcomeView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage(AppStorageConstants.hasOpenedAppBefore.rawValue) var hasOpenedAppBefore: Bool = false
    @State private var isNavigatingToLogin = false
    
    var body: some View {
        VStack {
            Text("Go Outdoor")
            
            Spacer()
            
            Image(AssetsImages.HikingBoy.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 450)
                .padding(.horizontal)
            
            Spacer()
            
            Text("Plan your adventure with ease")
                .font(.title2)
                .bold()
            Text("Discover new trails and routes")
            
            GORoundedButton(title: "Continue", isEnabled: .constant(true)) {
                hasOpenedAppBefore = true // Set the value to true
                isNavigatingToLogin = true // Navigate to the Login screen
            }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $isNavigatingToLogin) {
                LoginView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
