//
//  ProfileViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI
import PhotosUI

final class ProfileViewModel: ObservableObject {
    @Published var localUser: LocalUserFirestore?
    @Published var pseudo: String = ""
    @Published var email: String = ""
    @Published var isModifyingPseudo: Bool = false
    @Published var isModifyingEmail: Bool = false
    @Published var showAlert: Bool = false
    @Published var hasModifiedProfilePicture: Bool = false
    @Published var selectedCoverImage: PhotosPickerItem?
    @Published var uiProfileImage: UIImage?
    @Published var uiProfileImageData: Data?
    
    func fetchData(_ userID: String) async {
        if let user = await FirestoreManager.shared.read(userID) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.localUser = user
                self.pseudo = user.pseudo
                self.email = user.email
                // TODO: Handle image loading
            }
        }
    }
    
    func onSelectedCoverImageChange() {
        uiProfileImage = nil
        guard let item = selectedCoverImage else { return }
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let imageData):
                if let imageData,
                   let uiImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.uiProfileImage = uiImage
                        self.uiProfileImageData = imageData
                        self.hasModifiedProfilePicture = true
                    }
                } else {
                    print("No supported content type found.")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
