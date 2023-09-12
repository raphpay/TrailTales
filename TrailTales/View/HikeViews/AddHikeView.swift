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
        VStack {
            TTTextField(title: "Name", placeholder: "Enter a name for your hike", text: $viewModel.name)
            TTTextField(title: "Location", placeholder: "Where was your hike?", text: $viewModel.location)
            TTTextField(title: "Distance", placeholder: "What distance did you covered?", keyboardType: .decimalPad,
                        text: $viewModel.distance)
            TTTextField(title: "Difficulty", placeholder: "How difficult was it?", text: $viewModel.difficulty)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.uiImages, id: \.self) { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            
            PhotosPicker(selection: $viewModel.selectedImages) {
                Text("Pick photos from your hike")
            }
            .onChange(of: viewModel.selectedImages) { _ in
                viewModel.onSelectedImagesChange()
            }

            
            Button {
                saveHike()
            } label: {
                Text("Save Hike")
            }
        }
        .alert("An error occured", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
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

