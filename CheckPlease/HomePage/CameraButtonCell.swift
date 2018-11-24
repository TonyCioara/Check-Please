//
//  CameraButtonCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 11/15/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CameraButtonCell: UITableViewCell {
    
    func setUp() {
        addSubviews()
        setConstraints()
    }
    
    //    MARK: - Private
    private func addSubviews() {
        [cameraImageView, titleLabel].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(16)
        }
        cameraImageView.snp.makeConstraints { (make) in
            make.width.equalTo(cameraImageView.snp.height).multipliedBy(320 / 416)
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(100)
        }
    }
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "cameraIcon")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold22
        label.textColor = AppColors.darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "You have no previous receipts. Take a photo of your first receipt!"
        return label
    }()
}
