//
//  StorageManager.swift
//  instaClone
//
//  Created by Vinicius Bruno on 20/08/21.
//

import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error{
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void){
        
    }
    public func dowloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        })
    }
}

public enum UserPostType{
    case photo, video
}

public struct UserPost {
    let postType:  UserPostType
}
