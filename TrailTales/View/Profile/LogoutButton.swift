//
//  LogoutButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct LogoutButton: View {
    @EnvironmentObject var authDataProvider: AuthDataProvider
    
    var body: some View {
        Button {
            authDataProvider.logout()
        } label: {
            Text("Log out")
                .foregroundColor(.red)
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
    }
}
