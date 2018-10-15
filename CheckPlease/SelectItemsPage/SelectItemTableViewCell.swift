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
    
    func setUp() {
        
        titleLabel.text = "Chicken Katsu"
        priceLabel.text = "$5"
        
        addSubviews()
        setConstraints()
        setUpTapGesture()
        
        containerView.layer.cornerRadius = (self.frame.height - 16) / 2
        bubbleView.layer.cornerRadius = (self.frame.height - 32) / 2
    }
    
    //    MARK: - Private
    
    private let containerView: UIView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular18
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.regular18
        return label
    }()
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.mediumBlue
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColors.darkGray.cgColor
        view.isHidden = true
        return view
    }()
    
    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        bubbleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(bubbleView.snp.height)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(bubbleView.snp.left).offset(-8)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
        }
        
    }
    
    private func addSubviews() {
        self.addSubview(containerView)
        
        [titleLabel, priceLabel, bubbleView].forEach { (view) in
            containerView.addSubview(view)
        }
    }
    
    private func setUpTapGesture() {
        self.selectionStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        containerView.addGestureRecognizer(tap)
    }
    
    private var timer = Timer()
    
    @objc private func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        bubbleView.isHidden = !bubbleView.isHidden
        containerView.backgroundColor = AppColors.lightGray
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { (_) in
            self.containerView.backgroundColor = AppColors.white
        })
    }
}


