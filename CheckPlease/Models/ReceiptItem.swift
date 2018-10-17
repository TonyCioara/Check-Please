//
//  ReceiptItem.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ReceiptItem {
    
    var name: String
    var price: String
    var claimed: Bool
    
    init(name: String, price: String) {
        self.name = name
        self.price = price
        self.claimed = false
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.price = json["price"].stringValue
        self.claimed = false
    }
}
