//
//  User.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

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
    }
    
    /// Called when the local user's chatroom partner has stopped sharing their video feed.
    /// - Returns: Boolean value indicating if caching was successful.
    func cache() -> Bool {
        let fileURL = FileManager.default
            .urls(for: .cachesDirectory, in: .allDomainsMask)
            .first!
            .appendingPathComponent("user.plist")
        return dictionary.write(to: fileURL, atomically: true)
    }
    
    // MARK: - Private
    
    /// NSDictionary representation of user object used to facilitate caching to
    /// document directory.
    private var dictionary: NSDictionary {
        return [
            "id": id,
            "token": token
        ]
    }
}
