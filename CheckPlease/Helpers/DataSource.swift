//
//  DataSource.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

class DataSource {
    
    static let user1 = User(email: "tony@mail.com", firstName: "Tony", lastName: "Cioara", phoneNumber: "9712810024")
    static let user2 = User(email: "erik@mail.com", firstName: "Erik", lastName: "Perez", phoneNumber: "5059728022")
    static let user3 = User(email: "elliot@mail.com", firstName: "Elliot", lastName: "Olivera", phoneNumber: "1234567890")
    static let user4 = User(email: "perry@mail.com", firstName: "Perry", lastName: "ThePlatipus", phoneNumber: "4444444444")
    static let user5 = User(email: "hello@mail.com", firstName: "Hello", lastName: "Hey", phoneNumber: "1111112345")
    
    static let users = [user1, user2, user3, user4, user5]
}
