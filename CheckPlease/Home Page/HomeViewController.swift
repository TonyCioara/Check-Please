//
//  HomeViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let fullReceiptCellId = "fullReceiptCellId"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FullReceiptCell.self, forCellReuseIdentifier: "fullReceiptCellId")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func addSubviews() {
        [tableView].forEach { (view) in
            self.view.addSubview(view)
        }
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setUpViews() {
        self.title = "Past Receipts"
        addSubviews()
        setConstraints()
        setUpTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: fullReceiptCellId, for: indexPath) as! FullReceiptCell
        cell.setUp()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        height of collectionView + (height of 3 constraints (16 + 8 + 8) + height of label and a bit extra for the bottom)
        let cellHeight = (self.view.frame.width / (1.8 * 5)) + 56
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ReceiptDetailsViewController(), animated: true)
    }
}
