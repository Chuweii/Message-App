//
//  RegistractionViewuserInfo.swift
//  Message App
//
//  Created by NeferUser on 2023/2/11.
//
import UIKit
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
        return email?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
        password?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
        password!.count >= 6 &&
        userName?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
        fullName?.trimmingCharacters(in: .whitespaces).isEmpty == false
    }
    
    // MARK: - Function
    
    func handleRegistraction(profileImage: UIImage, vc: UIViewController) {
                
        let credentials = RegistractionCredentials(email: email!, password: password!, username: userName!, fullname: fullName!, profileImage: profileImage)
        
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                vc.signInErrorAlert(title: "Sign Up Error", message: error.localizedDescription)
            }
            print("Successful to sign up!")
            vc.dismiss(animated: true)
        }
    }
}
