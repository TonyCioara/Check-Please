//
//  PaysplitImageInfo.swift
//  CheckPlease
//
//  Created by Erik Perez on 11/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

final class PaysplitImageInfo {
    let uuid = UUID().uuidString
    let filename: String
    let imageData: Data
    
    init(filename: String, imageData: Data) {
        self.filename = filename
        self.imageData = imageData
    }
    
    convenience init?(filename: String, image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            return nil
        }
        self.init(filename: filename, imageData: imageData)
    }
}
