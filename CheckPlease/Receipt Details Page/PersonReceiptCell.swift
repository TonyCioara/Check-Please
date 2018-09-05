//
//  PreviousReceiptCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PreviousReceiptCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold14
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium14
        label.textColor = AppColors.mediumBlue
        label.textAlignment = .right
        return label
    }()
    
    let itemsLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular12
        label.numberOfLines = 0
        return label
    }()
    
    let sideLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    func addSubviews() {
        
        [profileImageView, nameLabel, usernameLabel, priceLabel, itemsLabel, sideLine, bottomLine].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    func setConstraints() {
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        sideLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(1)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        itemsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sideLine.snp.right).offset(8)
            make.top.equalTo(sideLine.snp.top)
            make.bottom.lessThanOrEqualTo(sideLine.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(itemsLabel.snp.right).offset(16)
        }
    }
    
    func setUp() {
        addSubviews()
        setConstraints()
        
        priceLabel.text = "$11"
        itemsLabel.text = "Rice Bowl, Dinner Set, Beer"
        nameLabel.text = "Tony Cioara"
        usernameLabel.text = "@Tony-Cioara"
        profileImageView.image = #imageLiteral(resourceName: "IMG_0932")
    }
}
