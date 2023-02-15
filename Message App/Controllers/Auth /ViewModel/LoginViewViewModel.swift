//
//  LoginViewViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import Foundation

struct LoginViewViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
