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
    
    @State private var localUser: LocalUser?
    @State private var pseudo: String = ""
    @State private var email: String = ""
    @State private var isModifyingPseudo: Bool = false
    @State private var isModifyingEmail: Bool = false
    @State private var showAlert: Bool = false
    @State private var hasModifiedProfilePicture: Bool = false
    @State private var selectedCoverImage: PhotosPickerItem?
    @State private var uiProfileImage: UIImage?
    @State private var uiProfileImageData: Data?
    
    var body: some View {
        ZStack {
            // MARK: - Background Image
            Rectangle()
              .foregroundColor(.clear)
              .background(.white.opacity(0.8))
              .background(
                Image(AssetsImages.ProfileBackground.rawValue)
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .clipped()
              )
              .edgesIgnoringSafeArea(.all)
            
            if let user = localUser {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: -  User Avatar/Profile Picture
                    HStack {
                        Spacer()
                        if let uiImage = uiProfileImage {
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
                    
                    PhotosPicker(selection: $selectedCoverImage) {
                        HStack {
                            Spacer()
                            Text("Modify the profile picture")
                            Spacer()
                        }
                    }
                    .onChange(of: selectedCoverImage) { _ in
                        onSelectedCoverImageChange(for: user)
                    }
                    if let data = uiProfileImageData,
                       hasModifiedProfilePicture {
                        SaveProfilePictureButton(user: user, data: data, hasModifiedProfilePicture: $hasModifiedProfilePicture)
                    }
                    
                    // MARK: - User Name/Pseudo
                    UserNameView(user: user, pseudo: $pseudo, isModifyingPseudo: $isModifyingPseudo)
                    
                    // MARK: - User Email
                    UserEmailView(userMail: user.emailAddress, email: $email, isModifyingEmail: $isModifyingEmail)
                    
                    // MARK: - Modify Pseudo Button
                    ModifyPseudoButton(userID: user.firebaseID, pseudo: $pseudo, isModifyingPseudo: $isModifyingPseudo)
                    
                    // MARK: - Modify Email Button
                    ModifyEmailButton(isModifyingEmail: $isModifyingEmail)
                    
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
                        showAlert = true
                    }
            }
        }
        .onAppear {
            if let uid = authDataProvider.currentUser?.uid,
               let user = LocalUserManager.shared.getLocalUser(with: uid) {
                self.localUser = user
                if let userProfilePicData = user.profilePicture,
                   let userProfilePicUIImage = UIImage(data: userProfilePicData) {
                    uiProfileImage = userProfilePicUIImage
                }
            }
        }
        .alert("Re-authenticate yourself", isPresented: $showAlert) {
            Button(role: .destructive) {
                authDataProvider.logout()
            } label: {
                Text("Log out")
            }
        }
    }
    
    func onSelectedCoverImageChange(for user: LocalUser) {
        uiProfileImage = nil
        guard let item = selectedCoverImage else { return }
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let imageData):
                if let imageData,
                   let uiImage = UIImage(data: imageData) {
                    uiProfileImage = uiImage
                    uiProfileImageData = imageData
                    hasModifiedProfilePicture = true
                } else {
                    print("No supported content type found.")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

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

struct UserNameView: View {
    var user: LocalUser
    @Binding var pseudo: String
    @Binding var isModifyingPseudo: Bool

    var body: some View {
        VStack {
            if !isModifyingPseudo {
                HStack {
                    Spacer()
                    Text(user.pseudo)
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    Spacer()
                }
            } else if isModifyingPseudo || user.pseudo.isEmpty {
                TTTextField(title: "Pseudo", placeholder: "Enter a pseudo", text: $pseudo)
                    .padding(.top, 10)
                    .onAppear {
                        pseudo = user.pseudo
                    }
            }
        }
    }
}

struct UserEmailView: View {
    var userMail: String
    @Binding var email: String
    @Binding var isModifyingEmail: Bool
    
    var body: some View {
        VStack {
            if isModifyingEmail {
               TTTextField(title: "Email", placeholder: "Enter your email", text: $email)
                    .onAppear {
                        email = userMail
                    }
            } else {
                HStack {
                    Spacer()
                    Text(userMail)
                        .font(.subheadline)
                        .bold()
                        .padding(.top, 10)
                    Spacer()
                }
            }
        }
    }
}

struct ModifyPseudoButton: View {
    var userID: String
    @Binding var pseudo: String
    @Binding var isModifyingPseudo: Bool
    
    var body: some View {
        if isModifyingPseudo {
            Button {
                LocalUserManager.shared.updatePseudo(pseudo, for: userID)
                isModifyingPseudo = false
            } label: {
                Text("Save Pseudo")
            }
        } else {
            Button {
                isModifyingPseudo = true
            } label: {
                Text("Modify Pseudo")
            }
        }
    }
}

struct ModifyEmailButton: View {
    @Binding var isModifyingEmail: Bool
    
    var body: some View {
        if isModifyingEmail {
            Button {
                isModifyingEmail = false
            } label: {
                Text("Save Email")
            }
        } else {
            Button {
                isModifyingEmail = true
            } label: {
                Text("Modify Email")
            }
        }
    }
}

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

// Define other components like UserAvatar, UserEmailView, ModifyPseudoButton, etc., similarly.


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
