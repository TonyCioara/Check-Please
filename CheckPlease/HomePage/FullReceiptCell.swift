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
    
    func setUp() {
        
        // Add data to views
        titleLabel.text = "Grandma's Deli"
        priceLabel.text = "$126"
        timeLabel.text = "11m"
        
        setUpCollectionView()
        addSubviews()
        setConstraints()
    }
    
    //    MARK: - Private
    
//    Replace this with the actual model when you get it
    private let model = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    
    private let personPortraitCellId = "personPortraitCellId"
    private let totalPeopleCellId = "totalPeopleCellId"
    
    private let collectionViewLineSpacing: CGFloat = 10
    
    private var collectionView: UICollectionView!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold18
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium14
        label.textColor = AppColors.darkBlue
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light14
        return label
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    private func addSubviews() {
        [collectionView, titleLabel, timeLabel, priceLabel, bottomLine].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(16)
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
            make.top.right.equalToSuperview().inset(16)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            // make.centerY.equalTo(collectionView)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(PersonPortraitCell.self, forCellWithReuseIdentifier: personPortraitCellId)
        collectionView.register(TotalPeopleCell.self, forCellWithReuseIdentifier: totalPeopleCellId)
        collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension FullReceiptCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model.count < 5 {
            return model.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: totalPeopleCellId, for: indexPath) as! TotalPeopleCell
            cell.setUp(count: model.count - 4)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personPortraitCellId, for: indexPath) as! PersonPortraitCell
            cell.setUp(image: #imageLiteral(resourceName: "IMG_0932"))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
}
