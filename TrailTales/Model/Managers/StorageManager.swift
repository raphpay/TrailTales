//
//  StorageManager.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import Foundation
import FirebaseCore
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storageRef = Storage.storage().reference()
    private let USERS_COLLECTION = "users-profile-pictures"
    
    private init() {}
    
    // MARK: - Upload
    func uploadProfilePicture(_ data: Data, for userID: String) async -> StorageMetadata? {
        let imageRef = storageRef.child("\(USERS_COLLECTION)/\(userID).jpg")
        var uploadTask: StorageMetadata?
        do {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            uploadTask = try await imageRef.putDataAsync(data, metadata: metadata)
        } catch let error {
            print("Error uploading image to storage for \(userID)", error.localizedDescription)
        }
        return uploadTask
    }
    
    // MARK: - Download
    func downloadProfilePicture(at path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let imageRef = storageRef.child(path)
        
        imageRef.getData(maxSize: 1 * 1024 * 1024) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error getting profile picture at \(path)", error.localizedDescription)
                completion(.failure(error))
                break
            }
        }
    }
    
    // MARK: - Delete
}
