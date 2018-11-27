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
    
    var description: String {
        return "ID: \(id),\nAuth token: \(token),\n"
    }
    
    init(token: String, id: String) {
        self.token = token
        self.id = id
    }
  
    init?(json: [String: Any]) {
        guard let token = json["auth_token"] as? String,
            let id = json["user_id"] as? String else {
                return nil
        }
        
        self.token = token
        self.id = id
        self.cache()
    }
    
    static func getId() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userId")
    }
    
    static func gettoken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userToken")
    }
    
    /// Stores user auth token and ID in keychain and sets isLoggedIn boolean in User Defaults
    func cache() {
        let keychain = KeychainSwift()
        keychain.set(id, forKey: "userId")
        keychain.set(token, forKey: "userToken")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
}
