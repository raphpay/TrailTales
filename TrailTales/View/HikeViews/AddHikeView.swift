//
//  AddHikeView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI

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
            
            Button {
                saveHike()
            } label: {
                Text("Save Hike")
            }
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
                    realm.add(hikeToSave)
                    filteredHikes.append(hikeToSave)
                    dismiss()
                } else {
                    // TODO: Show alert
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

