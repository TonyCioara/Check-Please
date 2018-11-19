//
//  PaysplitImageInfo.swift
//  CheckPlease
//
//  Created by Erik Perez on 11/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

final class PaysplitImageInfo {
    let uuid: String
    let filename: String
    let imageData: Data
    
    init(imageData: Data) {
        // FIXME: find better solution to replace filename
        // - Does unsaved recently captured photo have a filename?
        let uuid = UUID().uuidString
        self.filename = uuid
        self.uuid = uuid
        self.imageData = imageData
    }
    
    
    convenience init?(image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            return nil
        }
        self.init(imageData: imageData)
    }
}
