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
    
    func setUp(user: User, items: [ReceiptItem]) {
        addSubviews()
        setConstraints()
        
        var totalPrice = 0
        var itemsText = ""
        for index in 0..<items.count {
            let item = items[index]
            if let price = Int(item.price) {
                totalPrice += price
            }
            itemsText += item.name
            if index < items.count - 1 {
                itemsText += ", "
            }
        }
        
        priceLabel.text = "$" + String(totalPrice)
        itemsLabel.text = itemsText
        nameLabel.text = user.firstName + " " + user.lastName
        
        var phoneNumber = user.phoneNumber
        phoneNumber.formatPhoneNumber()
        phoneNumberLabel.text = phoneNumber
    }
    
    //    MARK: - Private
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold18
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light14
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium14
        label.textColor = AppColors.veryBlue
        label.textAlignment = .right
        return label
    }()
    
    private let itemsLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular12
        label.numberOfLines = 0
        return label
    }()
    
    private let sideLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    private func addSubviews() {
        
        [nameLabel, phoneNumberLabel, priceLabel, itemsLabel, sideLine, bottomLine].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
//        profileImageView.snp.makeConstraints { (make) in
//            make.top.bottom.left.equalToSuperview().inset(16)
//            make.width.equalTo(profileImageView.snp.height)
//        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
        }
        
        phoneNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        sideLine.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(1)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
        
        itemsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sideLine.snp.right).offset(8)
            make.top.equalTo(sideLine.snp.top)
            make.bottom.lessThanOrEqualTo(sideLine.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview().inset(16)
            make.left.equalTo(itemsLabel.snp.right).offset(16)
        }
    }
}
