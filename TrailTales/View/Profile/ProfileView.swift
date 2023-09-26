//
//  ProfileView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 25/09/2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var authDataProvider: AuthDataProvider
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            // MARK: - Background Image
            ClearBackgroundImage(image: AssetsImages.ProfileBackground.rawValue, opacity: 0.8)
            
            if let user = viewModel.localUser {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: -  User Avatar/Profile Picture
                    HStack {
                        Spacer()
                        if let uiImage = viewModel.uiProfileImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 100)
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    PhotosPicker(selection: $viewModel.selectedCoverImage) {
                        HStack {
                            Spacer()
                            Text("Modify the profile picture")
                            Spacer()
                        }
                    }
                    .onChange(of: viewModel.selectedCoverImage) { _ in
                        viewModel.onSelectedCoverImageChange(for: user)
                    }
                    if let data = viewModel.uiProfileImageData,
                       viewModel.hasModifiedProfilePicture {
                        SaveProfilePictureButton(user: user, data: data,
                                                 hasModifiedProfilePicture: $viewModel.hasModifiedProfilePicture)
                    }
                    
                    // MARK: - User Name/Pseudo
                    UserNameView(user: user, pseudo: $viewModel.pseudo,
                                 isModifyingPseudo: $viewModel.isModifyingPseudo)
                    
                    // MARK: - User Email
                    UserEmailView(userMail: user.emailAddress, email: $viewModel.email,
                                  isModifyingEmail: $viewModel.isModifyingEmail)
                    
                    // MARK: - Modify Pseudo Button
                    ModifyPseudoButton(userID: user.firebaseID, pseudo: $viewModel.pseudo,
                                       isModifyingPseudo: $viewModel.isModifyingPseudo)
                    
                    // MARK: - Modify Email Button
                    ModifyEmailButton(isModifyingEmail: $viewModel.isModifyingEmail)
                    
                    // MARK: - Modify Password Button
                    // TODO: Handle password modification with Firebase ( open dedicated issue )

                    // MARK: - Log out Button
                    Button(action: {
                        authDataProvider.logout()
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
                .padding()
            } else {
                EmptyView()
                    .onAppear {
                        viewModel.showAlert = true
                    }
            }
        }
        .onAppear {
            if let uid = authDataProvider.currentUser?.uid,
               let user = LocalUserManager.shared.getLocalUser(with: uid) {
                viewModel.localUser = user
                if let userProfilePicData = user.profilePicture,
                   let userProfilePicUIImage = UIImage(data: userProfilePicData) {
                    viewModel.uiProfileImage = userProfilePicUIImage
                }
            }
        }
        .alert("Re-authenticate yourself", isPresented: $viewModel.showAlert) {
            Button(role: .destructive) {
                authDataProvider.logout()
            } label: {
                Text("Log out")
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
