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
    
}
