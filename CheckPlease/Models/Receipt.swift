//
//  Receipt.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Receipt {
    
    var items: [ReceiptItem]
    
    init(items: [ReceiptItem]) {
        self.items = items
    }
    
}
