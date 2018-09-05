//
//  selectItemTableViewCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SelectItemTableViewCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColors.darkGray.cgColor
        
        view.layer.shadowColor = AppColors.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular18
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular18
        return label
    }()
    
    let portraitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColors.mediumBlue
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        return imageView
    }()
    
    func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        portraitImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(portraitImageView.snp.height)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(portraitImageView.snp.left).offset(-8)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
        }
        
    }
    
    func addSubviews() {
        self.addSubview(containerView)
        
        [titleLabel, priceLabel, portraitImageView].forEach { (view) in
            containerView.addSubview(view)
        }
    }
    
    func setUp() {
        
        titleLabel.text = "Chicken Katsu"
        priceLabel.text = "$5"
        
        addSubviews()
        setConstraints()
        
        containerView.layer.cornerRadius = (self.frame.height - 16) / 2
        portraitImageView.layer.cornerRadius = (self.frame.height - 32) / 2
    }
}


