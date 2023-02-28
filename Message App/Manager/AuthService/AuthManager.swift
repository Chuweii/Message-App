//
//  AuthManager.swift
//  Message App
//
//  Created by NeferUser on 2023/2/16.
//

import Firebase
import FirebaseStorage
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: -  Properties
    
    private let auth = Auth.auth()
    
    public var isSignedIn:Bool{
        return auth.currentUser != nil
    }
    
    // MARK: - Sign In & Sign Out
    
    public func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else{
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                completion(false, error)
                return
            }
            completion(true, error)
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void){
        do{
            try auth.signOut()
            completion(true)
        }
        catch{
            print(error)
            completion(false)
        }
    }
    
    // MARK: - Sign Up & Create User
    
    public func signUp(credentials: Credentials, completion: @escaping (Error?) -> Void){
        /// Save userinfo to firebase storage & create user
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData,metadata: nil) { (meta, error) in
            if let error = error {
                completion(error)
                return
            }
            
            ref.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                self.auth.createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    guard result != nil , error == nil else{
                        completion(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email": credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        if let error = error {
                            completion(error)
                        }
                        completion(error)
                    }
                }
            }
        }
    }
}
    
