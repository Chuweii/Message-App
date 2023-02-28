//
//  LoginViewViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import UIKit
import JGProgressHUD

struct LoginViewViewModel {
    
    // MARK: - Properties
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
        password?.trimmingCharacters(in: .whitespaces).isEmpty == false
        && password!.count >= 6
    }
    
    // MARK: - Method
    
    func checkUserLogin(vc: UIViewController) {
        vc.showLoader(true, withText: "Loging in ...")
        
        AuthManager.shared.signIn(email: email!, password: password!) { result, error  in
            if result{
                DispatchQueue.main.async {
                    vc.showLoader(false)
                    let viewController = ConversationController()
                    let navVC = UINavigationController(rootViewController: viewController)
                    navVC.navigationBar.prefersLargeTitles = true
                    navVC.modalPresentationStyle = .fullScreen
                    vc.present(navVC, animated: true)
                }
            } else {
                vc.showLoader(false)
                guard let error = error?.localizedDescription else { return }
                vc.normalAlert(title: "Sign in error", message: error)
            }
        }
    }
}
