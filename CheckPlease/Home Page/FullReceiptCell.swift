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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(PersonPortraitCell.self, forCellWithReuseIdentifier: "personPortraitCellId")
        return collectionView
    }()
    
    func addSubviews() {
        [collectionView].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    func setUp() {
        addSubviews()
        setUpCollectionView()
        setConstraints()
    }
}

extension FullReceiptCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        collectionView.frame = self.bounds
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
        return CGSize(width: self.frame.height, height: self.frame.height)
    }
    
    
}
