//
//  User.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    let username: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    
    init(email: String, username: String, firstName: String, lastName: String, phoneNumber: String) {
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
  
    init(json: JSON) {
        self.email = json["email"].stringValue
        self.username = json["username"].stringValue
        self.firstName = json["firstName"].stringValue
        self.lastName = json["lastName"].stringValue
        self.phoneNumber = json["phoneNumber"].stringValue
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
            "username": username,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber
        ]
    }
}
