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
    
    func setUp(image: UIImage) {
        addSubviews()
        setUpImageView()
        personImageView.image = image
    }
    
    //    MARK: - Private
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        return imageView
    }()
    
    private func setUpImageView() {
        personImageView.frame = self.bounds
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
    }
    
    private func addSubviews() {
        [personImageView].forEach { (view) in
            self.addSubview(view)
        }
    }
}
