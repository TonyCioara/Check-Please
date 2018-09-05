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
    
    let personPortraitCellId = "personPortraitCellId"
    let collectionViewLineSpacing: CGFloat = 10
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(PersonPortraitCell.self, forCellWithReuseIdentifier: "personPortraitCellId")
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = false
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold14
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium14
        label.textColor = AppColors.darkBlue
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light14
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    func addSubviews() {
        [collectionView, titleLabel, timeLabel, priceLabel, bottomLine].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(collectionView.snp.right)
        }
        
        let collectionViewHeight = self.frame.width / (1.8 * 5)
        let collectionViewWidth = self.frame.width / 1.8 + collectionViewLineSpacing * 4
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(collectionViewHeight)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(collectionViewWidth)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            // make.centerY.equalTo(collectionView)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
    }
    
    func setUp() {
        
        // Add data to views
        titleLabel.text = "Grandma's Deli"
        priceLabel.text = "$126"
        timeLabel.text = "11m"
        
        
        addSubviews()
        setUpCollectionView()
        setConstraints()
    }
}

extension FullReceiptCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        // collectionView.frame = CGRect(x: 8, y: 8, width: self.bounds.width - 16, height: self.bounds.height - 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personPortraitCellId, for: indexPath) as! PersonPortraitCell
        cell.setUp(image: #imageLiteral(resourceName: "IMG_0932"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    
}
