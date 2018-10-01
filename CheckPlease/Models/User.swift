//
//  User.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

struct User {
    
    var email: String
    var username: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(email: String, username: String, firstName: String, lastName: String, phoneNumber: String) {
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    init(userDict: Dictionary<String, String>) {
        let email = userDict["email"] ?? ""
        let username = userDict["username"] ?? ""
        let firstName = userDict["firstName"] ?? ""
        let lastName = userDict["lastName"] ?? ""
        let phoneNumber = userDict["phoneNumber"] ?? ""
        self.init(email: email, username: username, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
    }
    
}
