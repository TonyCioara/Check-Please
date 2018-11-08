//
//  User.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import KeychainSwift

struct User {
    
    let token: String
    let id: String
    
    init(token: String, id: String) {
        self.token = token
        self.id = id
    }
  
    init(json: [String: Any]) {
        let token = json["auth_token"] as! String
        let id = json["user_id"] as! String
        
        self.token = token
        self.id = id
        cache()
    }
    
    // MARK: - Private
    
    /// Called when the local user's chatroom partner has stopped sharing their video feed.
    /// - Returns: Boolean value indicating if caching was successful.
    private func cache() {
        let keychain = KeychainSwift()
        keychain.set(id, forKey: "userId")
        keychain.set(token, forKey: "userToken")
    }
}
