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
    @Published var distance: String = ""
    @Published var difficulty: HikeDifficulty = .medium
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
        print("onSelectedCoverImageChange", selectedCoverImage)
        guard let item = selectedCoverImage else { return }
        item.loadTransferable(type: Data.self) { [weak self] result in
            print("onSelectedCoverImageChange result", result)
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
