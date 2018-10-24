//
//  Contact.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Contact {
    
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}

