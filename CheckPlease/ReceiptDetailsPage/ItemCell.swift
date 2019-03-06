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

class ItemCell: UITableViewCell {
    
    func setUp(item: ReceiptItem) {
        addSubviews()
        setConstraints()

        nameLabel.text = item.product
        priceLabel.text = "$" + item.price
    }
    
    //    MARK: - Private
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.darkGray
        label.font = AppFonts.regular14
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.darkGray
        label.font = AppFonts.medium14
        return label
    }()
    
    private func addSubviews() {
        
        [nameLabel, priceLabel].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.left.greaterThanOrEqualTo(nameLabel.snp.right).offset(16)
        }
    }
}
