//
//  InfoCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 11/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class InfoCell: UITableViewCell {
    
    func setUp(createdAt: String, totalPrice: Float) {
        
        priceLabel.text = "$" + String(roundf(totalPrice * 100) / 100)
        let timeComponents1 = createdAt.split(separator: "T")
        let timeComponents2 = String(timeComponents1[1]).split(separator: ".")
        dateLabel.text = String(timeComponents1[0])
        timeLabel.text = String(timeComponents2[0])
        
        self.backgroundColor = AppColors.black.withAlphaComponent(0.85)
        addSubviews()
        setConstraints()
    }
    
    //    MARK: - Private
    
    private func addSubviews() {
        [priceLabel, dateLabel, timeLabel].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
            make.left.greaterThanOrEqualTo(dateLabel.snp.right).offset(16)
            make.left.greaterThanOrEqualTo(timeLabel.snp.right).offset(16)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.white
        label.font = AppFonts.regular18
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.white
        label.font = AppFonts.regular14
        return label
    }()

    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.mediumBlue
        label.font = AppFonts.medium18
        return label
    }()
    
    private func formatTime() {
        
    }
}
