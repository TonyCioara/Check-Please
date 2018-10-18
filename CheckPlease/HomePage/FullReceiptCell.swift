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
        
//        setUpCollectionView()
        addSubviews()
        setConstraints()
    }
    
    //    MARK: - Private
    
//    Replace this with the actual model when you get it
    private let model = Array(1 ... 99)
    
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
        label.textColor = AppColors.veryBlue
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
    
    private let previewLabel1: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = "Hello"
        return label
    }()
    
    private let previewLabel2: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = "Hello"
        return label
    }()
    
    private let previewLabel3: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        label.text = "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
        return label
    }()
    
    private func addSubviews() {
        [titleLabel, timeLabel, priceLabel, bottomLine, previewLabel1, previewLabel2, previewLabel3].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
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
