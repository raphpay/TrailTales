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
    @EnvironmentObject var authViewModel: AuthViewModel

    @Binding var filteredHikes: [Hike]
    
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var distance: String = ""
    @State private var difficulty: String = ""
    
    var body: some View {
        VStack {
            GOTextField(title: "Name", placeholder: "Enter a name for your hike", text: $name)
            GOTextField(title: "Location", placeholder: "Where was your hike?", text: $location)
            GOTextField(title: "Distance", placeholder: "What distance did you covered?", keyboardType: .decimalPad,
                        text: $distance)
            GOTextField(title: "Difficulty", placeholder: "How difficult was it?", text: $difficulty)
            
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
                if let currentUser = authViewModel.currentUser {
                    let hikeToSave = Hike(name: name, location: location, distance: distance, difficulty: difficulty, ownerId: currentUser.uid)
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

