//
//  StringExtensions.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/24/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isEmptyOrWhitespace: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespaces) == ""
    }
    
    mutating func formatPhoneNumber() {
        var a = 0
        var b = 3
        var c = 7
        if self.prefix(1) == "+" {
            a += 2
            b += 2
            c += 2
        }
        if self.count >= c {
            self.insert("-", at: self.index(self.startIndex, offsetBy: c - 1))
        }
        if self.count >= b {
            self.insert(")", at: self.index(self.startIndex, offsetBy: b))
        }
        self.insert("(", at: self.index(self.startIndex, offsetBy: a))
    }
}
