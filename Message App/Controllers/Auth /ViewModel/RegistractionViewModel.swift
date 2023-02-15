//
//  RegistractionViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/11.
//

import Foundation

struct RegistractionViewModel {
    var fullName: String?
    var userName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        && fullName?.isEmpty == false && userName?.isEmpty == false
    }
}
