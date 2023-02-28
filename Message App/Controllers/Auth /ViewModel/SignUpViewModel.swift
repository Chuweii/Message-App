//
//  SignUpViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/11.
//
import UIKit
import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth

struct SignUpViewModel {
    
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
    
    // MARK: - Method
    
    func handleSignUp(profileImage: UIImage, vc: UIViewController) {
        let credentials = Credentials(email: email!, password: password!, username: userName!, fullname: fullName!, profileImage: profileImage)
        vc.showLoader(true, withText: "Signing up ...")

        AuthManager.shared.signUp(credentials: credentials) { error in
            if error == nil {
                vc.showLoader(false)
                print("Success to sign up!")
                let viewController = ConversationController()
                vc.navigationController?.pushViewController(viewController, animated: true)
            } else {
                vc.showLoader(false)
                guard let error = error?.localizedDescription else { return }
                vc.normalAlert(title: "Sign up error", message: error)
            }
        }
    }
}
