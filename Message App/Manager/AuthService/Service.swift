//
//  Service.swift
//  Message App
//
//  Created by NeferUser on 2023/2/20.
//

import Firebase

class Service {
    
    static func fetchUser(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                let dic = document.data()
                let user = User(dictionary: dic)
                users.append(user)
                completion(users)
            })
        }
    }
}
