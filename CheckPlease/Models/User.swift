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
    
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(email: String, firstName: String, lastName: String, phoneNumber: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    init(json: JSON) {
        self.email = json["email"].stringValue
        self.firstName = json["firstName"].stringValue
        self.lastName = json["lastName"].stringValue
        self.phoneNumber = json["phoneNumber"].stringValue
    }
    
}
