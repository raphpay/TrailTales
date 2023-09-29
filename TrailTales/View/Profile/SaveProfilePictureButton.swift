//
//  SaveProfilePictureButton.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct SaveProfilePictureButton: View {
    
    var userID: String
    var data: Data
    @Binding var hasModifiedProfilePicture: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                // TODO: Save image on Firebase Storage
                Task {
                    let metadata = await StorageManager.shared.uploadProfilePicture(data, for: userID)
                    if let path = metadata?.path {
                        FirestoreManager.shared.updateProfilePicturePath(path, for: userID)
                    }
                }
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
        SaveProfilePictureButton(userID: MockData.localUserFirestore.uid, data: Data(), hasModifiedProfilePicture: .constant(false))
    }
}
