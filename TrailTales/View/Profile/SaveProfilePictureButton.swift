//
//  SaveProfilePictureButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct SaveProfilePictureButton: View {
    
    var user: LocalUser
    var data: Data
    @Binding var hasModifiedProfilePicture: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                LocalUserManager.shared.updateProfilePicture(data, for: user.firebaseID)
                hasModifiedProfilePicture = false
            } label: {
                Text("Save Profile Picture")
            }
            Spacer()
        }
    }
}

struct SaveProfilePictureButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveProfilePictureButton(user: MockData.localUser, data: Data(), hasModifiedProfilePicture: .constant(false))
    }
}
