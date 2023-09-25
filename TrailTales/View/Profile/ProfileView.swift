//
//  ProfileView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 25/09/2023.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var authDataProvider: AuthDataProvider
    @State private var localUser: LocalUser?
    @State private var pseudo: String = ""

    
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
            
            VStack(alignment: .leading, spacing: 10) {
                // MARK: -  User Avatar/Profile Picture
                HStack {
                    Spacer()
                    VStack {
                        if let picData = localUser?.profilePicture,
                           let picImage = UIImage(data: picData) {
                            Image(uiImage: picImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.top, 20)
                        } else {
                            Circle()
                                .frame(width: 100)
                                .padding(.top, 20)
                                .foregroundColor(.gray)
                        }
                        Button {
                            //
                        } label: {
                            Text("Modify the profile picture")
                        }

                    }
                    Spacer()
                }
                
                // MARK: - User Name/Pseudo
                
                
                if let pseudo = localUser?.pseudo {
                    HStack {
                        Spacer()
                        Text(pseudo)
                            .font(.title)
                            .bold()
                            .padding(.top, 10)
                        Spacer()
                    }
                } else {
                    TTTextField(title: "Pseudo", placeholder: "Enter a pseudo", text: $pseudo)
                        .padding(.top, 10)
                }
                
                // User Email
                HStack {
                    Spacer()
                    Text("user@email.com")
                        .font(.system(size: 18, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Spacer()
                }
                
                // Modify Email Button
                Button(action: {
                    // Add code to handle email modification here
                }) {
                    Text("Modify Email")
                        .foregroundColor(.blue)
                }
                
                // Modify Password Button
                Button(action: {
                    // Add code to handle password modification here
                }) {
                    Text("Modify Password")
                        .foregroundColor(.blue)
                }
                
                // Log Out Button
                Button(action: {
                    // Add code to handle log out here
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
