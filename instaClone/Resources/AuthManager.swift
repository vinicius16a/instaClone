//
//  AuthManager.swift
//  instaClone
//
//  Created by Vinicius Bruno on 20/08/21.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        /*
         - Check if username is avaliable
         - Check if email is avaliable
        
         */
        DatabaseManager.shared.canCreatNewUser(with: email, username: username){ canCreat in
            if canCreat{
                /*
                 - Creat account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard  error == nil, result != nil else{
                        completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username){inserted in
                        if inserted{
                            completion(true)
                            return
                        }else{
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                // either username our email does not exist
                completion(false)
            }
            
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)){
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error  in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }else if let username = username{
            //username log in
            print(username)
        }
    }
    public func logOut(completion: (Bool) -> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
    }
}
