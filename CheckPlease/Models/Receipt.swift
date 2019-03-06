//
//  Receipt.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

//"id": "217bafa0-e764-11e8-a7d6-292665ab97ba",
//"user_id": "e9600901-f3c5-4faa-aeb6-60b087872898",
//"merchant": "Walmart Supercenter",
//"location": "8885 N FLORIDA AVE, TAMPA FL 33604, ST # 5221 OP # 00001061 TE # 06 TR # 05332, ",
//"url": "http://images2.wikia.nocookie.net/__cb20111106201150/groceryreceipts/images/8/80/Grocery_receipts_001.jpg",
//"createdAt": "2018-11-13T16:49:47.935Z",
//"updatedAt": "2018-11-13T16:49:47.935Z",
//"deletedAt": null

struct Receipt {
    
    var items: [ReceiptItem] = []
    var id: String
    var userId: String
    var merchant: String
    var location: String
    var url: String
    var createdAt: String
    var updatedAt: String
    
    init(id: String, userId: String, merchant: String, location: String, url: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.userId = userId
        self.merchant = merchant
        self.location = location
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
