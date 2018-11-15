//
//  ReceiptItem.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

//"id": "4737b7c0-714a-44fc-bfbe-7f6397bd1a56",
//"receipt_id": "217bafa0-e764-11e8-a7d6-292665ab97ba",
//"invoice_id": null,
//"product": "BREAD 007225003712 F 2",
//"price": "2.88",
//"createdAt": "2018-11-13T16:49:47.993Z",
//"updatedAt": "2018-11-13T16:49:47.993Z",
//"deletedAt": null

struct ReceiptItem {
    
    var id: String
    var receiptId: String
    var invoiceId: String
    var product: String
    var price: String
    var createdAt: String
    var updatedAt: String
    
    init(id: String, receiptId: String, invoiceId: String, product: String, price: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.receiptId = receiptId
        self.invoiceId = invoiceId
        self.product = product
        self.price = price
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.receiptId = json["receipt_id"].stringValue
        self.invoiceId = json["invoice_id"].stringValue
        self.product = json["product"].stringValue
        self.price = json["price"].stringValue
        self.createdAt = json["createdAt"].stringValue
        self.updatedAt = json["updatedAt"].stringValue
    }
}
