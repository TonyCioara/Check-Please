//
//  User.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

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
    
    init?(json: [String: String]) {
        // TODO: Verify correct keys for json response
        guard
            let username = json["username"],
            let firstName = json["first_name"],
            let lastName = json["last_name"],
            let email = json["email"],
            let phoneNumber = json["phone_number"] else {
                return nil
        }
        
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
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
