//
//  StateButton.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/15/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func switchState() {
        self.isEnabled = !self.isEnabled
        if self.isEnabled {
            self.backgroundColor = AppColors.darkBlue
        } else {
            self.backgroundColor = AppColors.lightBlue
        }
    }
    
    func disable() {
        self.isEnabled = false
        self.backgroundColor = AppColors.lightBlue
    }

    func enable() {
        self.isEnabled = true
        self.backgroundColor = AppColors.darkBlue
    }
    
}
