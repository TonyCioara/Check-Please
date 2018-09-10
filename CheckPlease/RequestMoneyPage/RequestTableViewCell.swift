//
//  RequestTableViewCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RequestTableViewCell: UITableViewCell {
    
    let portraitImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold14
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    func addSubviews() {
        [portraitImageView, fullNameLabel, usernameLabel, bottomView].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    func setConstraints() {
        portraitImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(portraitImageView.snp.width)
        }
        
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(portraitImageView.snp.top)
            make.left.equalTo(portraitImageView.snp.right).offset(8)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(2)
            make.left.equalTo(fullNameLabel.snp.left)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-32)
            make.left.equalToSuperview().offset(32)
        }
    }
    
    func setUp() {
        addSubviews()
        setConstraints()
        
        portraitImageView.layer.cornerRadius = (self.frame.height - 32) / 2
        
        portraitImageView.image = #imageLiteral(resourceName: "IMG_0932")
        fullNameLabel.text = "Tony Cioara"
        usernameLabel.text = "@Tony-Cioara"
        
    }
}
