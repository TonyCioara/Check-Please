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
        if self.count >= 7 {
            self.insert("-", at: self.index(self.startIndex, offsetBy: 6))
        }
        if self.count >= 3 {
            self.insert(")", at: self.index(self.startIndex, offsetBy: 3))
        }
        self.insert("(", at: self.startIndex)
    }
}
