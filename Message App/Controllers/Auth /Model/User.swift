//
//  User.swift
//  Message App
//
//  Created by NeferUser on 2023/2/20.
//

import Foundation

struct User {
    let email: String
    let uid: String
    let profileImageUrl: String
    let username: String
    let fullname: String
    
    init(dictionary: [String: Any]) {
        self.username = (dictionary["username"] as? String) ?? ""
        self.uid = (dictionary["uid"] as? String) ?? ""
        self.profileImageUrl = (dictionary["profileImageUrl"] as? String) ?? ""
        self.email = (dictionary["email"] as? String) ?? ""
        self.fullname = (dictionary["fullname"] as? String) ?? ""
    }
}
