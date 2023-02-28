//
//  NewMessageViewModel.swift
//  Message App
//
//  Created by NeferUser on 2023/2/20.
//

import Foundation

class NewMessageViewModel {
    
    // MARK: - User Model
    
    var users = Dynamic([User]())
    
    func fetchUsers() {
        Service.fetchUser { users in
            self.users.value = users
        }
    }
}
