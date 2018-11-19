//
//  HomePageViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ReceiptDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receipt = DataSource.receipt
        receipt.items = [DataSource.receiptItem1, DataSource.receiptItem2, DataSource.receiptItem3, DataSource.receiptItem4, DataSource.receiptItem5]
        setUpViews()
    }
    
    //    MARK: - Private
    
    private var receipt: Receipt!
    
    private let itemCellId = "personReceiptCellId"
    private let infoCellId = "infoCellId"
    
    private let tableView = UITableView()
    
    private func addSubviews() {
        [tableView].forEach { (view) in
            self.view.addSubview(view)
        }
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        self.title = receipt.merchant
        self.view.backgroundColor = AppColors.white
        addSubviews()
        setConstraints()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: itemCellId)
        tableView.register(InfoCell.self, forCellReuseIdentifier: infoCellId)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReceiptDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipt.items.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! InfoCell
            var totalPrice: Float = 0
            for item in receipt.items {
                totalPrice += Float(item.price) ?? 0
            }
            cell.setUp(createdAt: receipt.createdAt, totalPrice: totalPrice)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellId, for: indexPath) as! ItemCell
        cell.setUp(item: receipt.items[indexPath.row - 1])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 72
        }
        return 40
    }
}
