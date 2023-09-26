//
//  AddHikeViewModel.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import RealmSwift
import PhotosUI

final class AddHikeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var distance: String = "" {
        didSet {
            // Allow blanks in the field, or they can't delete
            if distance == "" { return }

            // Check the entire value is good, otherwise ignore the change
            if let distanceInKm = Double(distance) {
                if distanceInKm < 0 { distance = oldValue }
            } else { distance = oldValue}

            // Pop alert or trigger any other UI instruction here
        }
    }
    @Published var difficulty: HikeDifficulty = .medium
    @Published var hourDuration: String = "" {
        didSet {
            // Allow blanks in the field, or they can't delete
            if hourDuration == "" { return }

            // Check the entire value is good, otherwise ignore the change
            if let hours = Int(hourDuration) {
                if hours < 0 { hourDuration = oldValue }
            } else { hourDuration = oldValue }

            // Pop alert or trigger any other UI instruction here
        }
    }
    @Published var minuteDuration: String = "" {
        didSet {
            // Allow blanks in the field, or they can't delete
            if minuteDuration == "" { return }

            // Check the entire value is good, otherwise ignore the change
            if let minutes = Int(minuteDuration) {
                if minutes < 0 || minutes > 59 { minuteDuration = oldValue }
            } else { minuteDuration = oldValue }

            // Pop alert or trigger any other UI instruction here
        }
    }
    @Published var hikeDate: Date = .now
    
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var selectedCoverImage: PhotosPickerItem?
    @Published var uiCoverImage: UIImage?
    @Published var selectedImages: [PhotosPickerItem] = []
    @Published var uiImages: [UIImage] = []
    
    func onSelectedImagesChange() {
        uiImages = []
        for item in selectedImages {
            item.loadTransferable(type: Data.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageData):
                    if let imageData,
                       let uiImage = UIImage(data: imageData) {
                        self.uiImages.append(uiImage)
                    } else {
                        print("No supported content type found.")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func onSelectedCoverImageChange() {
        uiCoverImage = nil
        guard let item = selectedCoverImage else { return }
        item.loadTransferable(type: Data.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageData):
                if let imageData,
                   let uiImage = UIImage(data: imageData) {
                    self.uiCoverImage = uiImage
                } else {
                    print("No supported content type found.")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
