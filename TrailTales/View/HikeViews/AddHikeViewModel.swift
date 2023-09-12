//
//  AddHikeViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import RealmSwift

final class AddHikeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var distance: String = ""
    @Published var difficulty: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
}
