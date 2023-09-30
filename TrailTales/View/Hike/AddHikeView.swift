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
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @StateObject private var viewModel = AddHikeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                if let coverPhoto = viewModel.uiCoverImage {
                    ClearBackgroundUIImage(uiImage: coverPhoto)
                }
                
                // MARK: - Toolbar Buttons
                closeButton
                saveButton
                
                
                ScrollView {
                    VStack(spacing: 10) {
                        
                        hikeForm
                        
                        coverPhotoPicker
                        
                        // TODO: Add multiple photo selection
                    }
                    .padding()
                }
                .padding(.top, 40)
            }
            .navigationBarTitle("Add Hike", displayMode: .inline)
        }
    }
    
    var hikeForm: some View {
        VStack {
            TTTextField(title: "Hike Name", placeholder: "Enter a name for the hike", text: $viewModel.name)
            TTTextField(title: "Hike Location", placeholder: "Where was the hike", text: $viewModel.location)
            
            DatePicker(selection: $viewModel.hikeDate, in: ...Date.now,
                       displayedComponents: .date) {
                Text("When did you hike?")
            }
            
            TTTextField(title: "Distance", placeholder: "What distance did you covered?",
                        keyboardType: .decimalPad, text: $viewModel.distance)
            
            HStack {
                TTTextField(title: "Hours", placeholder: "How many hours?",
                            keyboardType: .numberPad, text: $viewModel.hourDuration)
                TTTextField(title: "Minutes", placeholder: "How many minutes?",
                            keyboardType: .numberPad, text: $viewModel.minuteDuration)
            }
            
            HStack {
                Text("Hike Difficulty")
                Spacer()
            }
            Picker("Enter a hike difficulty", selection: $viewModel.difficulty) {
                ForEach(HikeDifficulty.allCases, id: \.self) { value in
                    Text(value.label)
                        .tag(value)
                }
            }
            .pickerStyle(.segmented)
            
            TTTextField(title: "Description", placeholder: "Notes about the hikes", text: $viewModel.story)
        }
    }
    
    var closeButton: some View {
        VStack {
            HStack {
                TTRoundedButton(icon: SFSymbols.close.rawValue, circleSize: 35, iconSize: 15) {
                    dismiss()
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var saveButton: some View {
        VStack {
            HStack {
                Spacer()
                TTRoundedButton(icon: SFSymbols.save.rawValue, circleSize: 35, iconSize: 15, foregroundColor: .greenish) {
                    saveHike()
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var coverPhotoPicker: some View {
        PhotosPicker(selection: $viewModel.selectedCoverImage) {
            Text("Choose a cover photo")
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                )
        }
        .foregroundColor(.blueish)
        .shadow(radius: 10)
        .padding(.trailing)
        .padding(.vertical)
        .onChange(of: viewModel.selectedCoverImage) { _ in
            viewModel.onSelectedCoverImageChange()
        }
    }
    
    func saveHike() {
        do {
            try realm.write({
                if let currentUser = authDataProvider.currentUser {
                    // TODO: Add a day textfield
                    let duration = Utils.convertToSeconds(days: 0, hours: Int(viewModel.hourDuration) ?? 0,
                                                        minutes: Int(viewModel.minuteDuration) ?? 0)
                    let hikeToSave = Hike(name: viewModel.name,
                                          location: viewModel.location,
                                          distance: viewModel.distance,
                                          difficulty: viewModel.difficulty,ownerId: currentUser.uid,
                                          durationInS: duration, date: viewModel.hikeDate,
                                          story: viewModel.story)
                    // TODO: Handle multiple photo support
                    if let compressedUIImage = viewModel.uiCoverImage?.getCompressedData() {
                        hikeToSave.coverPhoto = compressedUIImage
                    }
                    realm.add(hikeToSave)
                    mainViewModel.filteredHikes.append(hikeToSave)
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
        AddHikeView()
    }
}

