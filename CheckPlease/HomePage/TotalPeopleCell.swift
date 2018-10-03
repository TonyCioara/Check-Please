//
//  TotalPeopleCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TotalPeopleCell: UICollectionViewCell {
    
    func setUp(count: Int) {
        addSubviews()
        setConstraints()
        countLabel.text = "+" + String(count)
        containerView.layer.cornerRadius = self.frame.height / 2
    }
    
    //    MARK: - Private
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.semibold22
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = AppColors.darkBlue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private func addSubviews() {
        [containerView, countLabel].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
}
