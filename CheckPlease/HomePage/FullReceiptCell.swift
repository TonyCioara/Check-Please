//
//  FullReceiptCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FullReceiptCell: UITableViewCell {
    
    func setUp(indexPath: IndexPath, delegate: CellTapDelegate, receipt: Receipt) {
        
        // Add data to views
        self.receipt = receipt
        self.delegate = delegate
        self.indexPath = indexPath
        
        titleLabel.text = receipt.merchant
        var totalPrice = Float(0)
        for item in receipt.items {
            totalPrice += Float(item.price) ?? 0
        }
        priceLabel.text = "$" + String(roundf(totalPrice * 100) / 100)
        timeLabel.text = "abc"
        
        previewLabel1.text = String(receipt.items[0].product.split(separator: " ")[0])
        previewLabel2.text = String(receipt.items[1].product.split(separator: " ")[0])
        previewLabel3.text = String(receipt.items[2].product.split(separator: " ")[0])
        
        addSubviews()
        setConstraints()
        setUpTapGesture()
    }
    
    //    MARK: - Private
    
    private var receipt: Receipt?
    
    private var delegate: CellTapDelegate?
    private var indexPath: IndexPath?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold18
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
//        view.layer.borderWidth = 1
//        view.layer.borderColor = AppColors.darkGray.withAlphaComponent(0.5).cgColor
        
        view.layer.shadowColor = AppColors.darkGray.cgColor
        view.layer.shadowOpacity = 0.35
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium14
        label.textColor = AppColors.veryBlue
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light14
        return label
    }()
    
    private let previewLabel1: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = ""
        return label
    }()
    
    private let previewLabel2: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = ""
        return label
    }()
    
    private let previewLabel3: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = ""
        return label
    }()
    
    private func addSubviews() {
        self.addSubview(containerView)
        [titleLabel, timeLabel, priceLabel, previewLabel1, previewLabel2, previewLabel3].forEach { (view) in
            containerView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(16)
        }
        
        previewLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(timeLabel.snp.left).offset(-16)
        }
        
        previewLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(previewLabel1.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(timeLabel.snp.left).offset(-16)
        }
        
        previewLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(previewLabel2.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(timeLabel.snp.left).offset(-16)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(16)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(24)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
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
        containerView.backgroundColor = AppColors.lightGray
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { (_) in
            self.containerView.backgroundColor = AppColors.white
        })
        guard let indexPath = self.indexPath, let delegate = self.delegate else {return}
        delegate.cellWasTapped(indexPath: indexPath)
    }
}
