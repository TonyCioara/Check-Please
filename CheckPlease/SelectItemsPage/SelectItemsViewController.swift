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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //    MARK: - Private
    
    private var topCollectionView: UICollectionView!
    private let personPortraitCellId = "personPortraitCellId"
    
    private var tableView = UITableView()
    private let selectItemTableViewCellId = "selectItemTableViewCellId"
    
    private let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkBlue
        return view
    }()
    
    private let actionViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        return view
    }()
    
    private let actionViewButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Pay", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(payButtonTapped(sender: )), for: UIControlEvents.touchDown)
        return button
    }()
    
    private let actionViewButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Request", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(requestButtonTapped(sender: )), for: UIControlEvents.touchDown)
        return button
    }()
    
    private func addSubviews() {
        [tableView, actionView].forEach { (view) in
            self.view.addSubview(view)
        }
        
        [actionViewSeparator, actionViewButtonOne, actionViewButtonTwo].forEach { (view) in
            actionView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).priority(500)
            make.bottom.equalTo(actionView.snp.top)
        }
        
        actionView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        actionViewSeparator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(8)
            make.width.equalTo(2)
        }
        
        actionViewButtonOne.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(actionViewSeparator.snp.left)
        }
        
        actionViewButtonTwo.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(actionViewSeparator.snp.right)
        }
    }
    
    private func setUpViews() {
        self.title = "Select Items"
        self.view.backgroundColor = AppColors.white
        setUpCollectionView()
        setUpTableView()
        addSubviews()
        setConstraints()
    }
    
    @objc private func payButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func requestButtonTapped(sender: UIButton) {
        navigationController?.pushViewController(RequestMoneyViewController(), animated: true)
    }
    
    private func setUpTableView() {
        tableView.register(SelectItemTableViewCell.self, forCellReuseIdentifier: selectItemTableViewCellId)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        topCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), collectionViewLayout: layout)
        topCollectionView.register(PersonPortraitCell.self, forCellWithReuseIdentifier: personPortraitCellId)
        topCollectionView.backgroundColor = .white
        topCollectionView.allowsSelection = false
        topCollectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        topCollectionView.backgroundColor = AppColors.darkBlue
        topCollectionView.showsHorizontalScrollIndicator = false
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
    }
}

extension SelectItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: selectItemTableViewCellId, for: indexPath) as! SelectItemTableViewCell
        cell.setUp()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return topCollectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
}
