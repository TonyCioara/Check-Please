//
//  RequestPhoneNumberTableViewCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 10/16/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RequestPhoneNumberTableViewCell: UITableViewCell {
    
    func setUp(phoneNumber: String) {
        
        var phoneNumber = phoneNumber
        phoneNumber.formatPhoneNumber()
        phoneNumberLabel.text = phoneNumber
        descriptionLabel.text = "Send request through text message to:"
        self.addSubviews()
        self.setConstraints()
//        self.isUserInteractionEnabled = false
    }
    
    //    MARK: - Private
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold18
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light14
        return label
    }()
    
    private func addSubviews() {
        [descriptionLabel, phoneNumberLabel].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
        descriptionLabel.snp.makeConstraints { (make) in
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview().inset(16)
                make.right.greaterThanOrEqualToSuperview().inset(16)
            }
            
            phoneNumberLabel.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
                make.left.equalTo(descriptionLabel.snp.left).offset(6)
                make.right.greaterThanOrEqualToSuperview().inset(16)
            }
        }
    }
}
