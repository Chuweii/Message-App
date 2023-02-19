//
//  LoginViewViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import UIKit

struct LoginViewViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
        password?.trimmingCharacters(in: .whitespaces).isEmpty == false
        && password!.count >= 6
    }
    
    func checkUserLogin(vc: UIViewController) {
        AuthService.shared.signIn(email: email!, password: password!) { result in
            if result{
                DispatchQueue.main.async {
                    let viewController = ConversationController()
                    let navVC = UINavigationController(rootViewController: viewController)
                    navVC.navigationBar.prefersLargeTitles = true
                    navVC.modalPresentationStyle = .fullScreen
                    vc.present(navVC, animated: true)
                }
            }else{
                vc.signInErrorAlert(title: "Sign in error", message: "Please checked email and password again.")
            }
        }
    }
}
