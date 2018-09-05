//
//  SelectItemsViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SelectItemsViewController: UIViewController {
    
    var topCollectionView: UICollectionView!
    let personPortraitCellId = "personPortraitCellId"
    
    var tableView = UITableView()
    let selectItemTableViewCellId = "selectItemTableViewCellId"
    
    let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkBlue
        return view
    }()
    
    let actionViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        return view
    }()
    
    let actionViewButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Take Photo", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(actionViewButtonOneTapped(sender: )), for: UIControlEvents.touchDown)
        return button
    }()
    
    let actionViewButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(actionViewButtonTwoTapped(sender: )), for: UIControlEvents.touchDown)
        return button
    }()
    
    func addSubviews() {
        [tableView, topCollectionView, actionView].forEach { (view) in
            self.view.addSubview(view)
        }
        
        [actionViewSeparator, actionViewButtonOne, actionViewButtonTwo].forEach { (view) in
            actionView.addSubview(view)
        }
    }
    
    func setConstraints() {
        topCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(topCollectionView.snp.bottom)
            make.bottom.equalTo(actionView.snp.top)
        }
        
        actionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        actionViewSeparator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(2)
        }
        
        actionViewButtonOne.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalTo(actionViewSeparator.snp.left)
        }
        
        actionViewButtonTwo.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(actionViewSeparator.snp.right)
        }
    }
    
    func setUpViews() {
        self.title = "Select Items"
        setUpCollectionView()
        setUpTableView()
        addSubviews()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    @objc func actionViewButtonOneTapped(sender: UIButton) {
        
    }
    
    @objc func actionViewButtonTwoTapped(sender: UIButton) {
        
    }
}

extension SelectItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        topCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        topCollectionView.register(PersonPortraitCell.self, forCellWithReuseIdentifier: personPortraitCellId)
        topCollectionView.backgroundColor = .white
        topCollectionView.allowsSelection = false
        topCollectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        topCollectionView.backgroundColor = AppColors.darkBlue
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        You can find this cell in the home page folder
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personPortraitCellId, for: indexPath) as! PersonPortraitCell
        cell.setUp(image: #imageLiteral(resourceName: "IMG_0932"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
}

extension SelectItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        tableView.register(SelectItemTableViewCell.self, forCellReuseIdentifier: selectItemTableViewCellId)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: selectItemTableViewCellId, for: indexPath) as! SelectItemTableViewCell
        cell.setUp()
        return cell
    }
    
    
    
}
