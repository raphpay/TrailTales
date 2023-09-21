//
//  AddHikeView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import PhotosUI

struct AddHikeView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authDataProvider: AuthDataProvider

    @Binding var filteredHikes: [Hike]
    
    @StateObject private var viewModel = AddHikeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: - Cover
                ZStack(alignment: .bottomLeading) {
                    // MARK: - Cover image
                    if let uiImage = viewModel.uiCoverImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    } else {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: 300)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            TTRoundedButton(icon: SFSymbols.close.rawValue,
                                            circleSize: 35, iconSize: 15) {
                                dismiss()
                            }
                        }
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                        Spacer()
                    }
                    
                    HStack(alignment: .bottom) {
                        // MARK: - Hike Details
                        VStack(alignment: .leading) {
                            Text(viewModel.location)
                                .font(.title2)
                                .shadow(radius: 1)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.distance)
                                // TODO: Create a component for difficulty with a background
                                Text(viewModel.difficulty.label)
                            }
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                        // MARK: - Image cover picker
                        PhotosPicker(selection: $viewModel.selectedCoverImage) {
                            Text("Change cover")
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                        }
                        .foregroundColor(.gray)
                        .shadow(radius: 10)
                        .padding(.trailing)
                        .padding(.bottom)
                        .onChange(of: viewModel.selectedCoverImage) { _ in
                            viewModel.onSelectedCoverImageChange()
                        }
                    }
                }
                
                // MARK: - Textfields
                VStack {
                    TTTextField(title: "Name", placeholder: "Enter a name for your hike",
                                text: $viewModel.name)
                    TTTextField(title: "Location", placeholder: "Where was your hike?",
                                text: $viewModel.location)
                    TTTextField(title: "Distance", placeholder: "What distance did you covered?",
                                keyboardType: .decimalPad, text: $viewModel.distance)
                    Picker("This Title Is Localized", selection: $viewModel.difficulty) {
                        ForEach(HikeDifficulty.allCases, id: \.self) { value in
                            Text(value.label)
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                
                // MARK: - Save Hike button
                Button {
                    saveHike()
                } label: {
                    Text("Save Hike")
                }
            }
            .navigationTitle("Log your journey")
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func saveHike() {
        do {
            try realm.write({
                if let currentUser = authDataProvider.currentUser {
                    let hikeToSave = Hike(name: viewModel.name,
                                          location: viewModel.location,
                                          distance: viewModel.distance,
                                          difficulty: viewModel.difficulty,ownerId: currentUser.uid)
                    for uiImage in viewModel.uiImages {
                        if let imageData = uiImage.pngData() {
                            hikeToSave.photos.append(imageData)
                        }
                    }
                    if let coverImageData = viewModel.uiCoverImage?.pngData() {
                        hikeToSave.coverPhoto = coverImageData
                    }
                    realm.add(hikeToSave)
                    filteredHikes.append(hikeToSave)
                    dismiss()
                } else {
                    viewModel.showAlert = true
                    viewModel.alertMessage = "Cannot add hike for the moment. Please try again later."
                }
            })
        } catch let error {
            print(error)
        }
    }
}

struct AddHikeView_Previews: PreviewProvider {
    static var previews: some View {
        AddHikeView(filteredHikes: .constant([]))
    }
}

