//
//  personPortraitCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

class PersonPortraitCell: UICollectionViewCell {
    
    let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        return imageView
    }()
    
    func addSubviews() {
        [personImageView].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    func setConstraints() {
        personImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    func setUp(image: UIImage) {
        personImageView.image = image
    }
}
