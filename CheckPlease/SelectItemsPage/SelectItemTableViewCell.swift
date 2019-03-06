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
    
    func setUp(indexPath: IndexPath, delegate: CellTapDelegate, receiptItem: ReceiptItem) {
        
        titleLabel.text = receiptItem.product
        priceLabel.text = "$" + receiptItem.price 
        
        addSubviews()
        setConstraints()
        setUpTapGesture()
        
        containerView.layer.cornerRadius = (self.frame.height - 16) / 2
        bubbleView.layer.cornerRadius = (self.frame.height - 32) / 2
        
        self.indexPath = indexPath
        self.delegate = delegate
        
        switch indexPath.section {
        case 0:
            bubbleView.backgroundColor = AppColors.mediumBlue
            bubbleView.isHidden = true
        case 1:
            bubbleView.backgroundColor = AppColors.mediumGreen
            bubbleView.isHidden = false
        default:
            break
        }
    }
    
    //    MARK: - Private
    
    private var delegate: CellTapDelegate!
    private var indexPath: IndexPath!
    
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
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        
        bubbleView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview().inset(8)
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
        if indexPath.section == 0 {
            bubbleView.isHidden = !bubbleView.isHidden
            containerView.backgroundColor = AppColors.lightGray
            timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { (_) in
                self.containerView.backgroundColor = AppColors.white
            })
            delegate.cellWasTapped(indexPath: self.indexPath)
        }
    }
}


