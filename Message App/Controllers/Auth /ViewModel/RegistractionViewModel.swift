//
//  RegistractionViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/11.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth

struct RegistractionViewModel {
    
    // MARK: - Properties
    
    var fullName: String?
    var userName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        && fullName?.isEmpty == false && userName?.isEmpty == false
    }
    
    // MARK: - Function
    
    func saveProfileInfo(imageData: Data) {
        guard let email = email else { return }
        guard let password = password else { return }
        guard let fullname = fullName else { return }
        guard let username = userName else { return }        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData,metadata: nil) { (meta, error) in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }

            ref.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error \(error.localizedDescription)")
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email": email,
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": username] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        if let error = error {
                            print("DEBUG: Failed to upload user with error \(error.localizedDescription)")
                        }
                        
                        print("DEBUG: Did create user..")
                    }
                }
            }
        }
    }
}
