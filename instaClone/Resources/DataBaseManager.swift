//
//  DataBaseManager.swift
//  instaClone
//
//  Created by Vinicius Bruno on 20/08/21.
//

import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    /// check if username and email is avaliable
    /// - Parameters
    ///     - email: String represeting email
    ///     - username: String represeting username

    public func canCreatNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    
    /// insert new user data to database
    /// - Parameters
    ///     - email: String represeting email
    ///     - username: String represeting username
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]) {  error, _ in
            if error == nil{
                //sucess
                completion(true)
                return
            }else{
                // deu ruim
                completion(false)
                return
            }
        }
    }
 
}
