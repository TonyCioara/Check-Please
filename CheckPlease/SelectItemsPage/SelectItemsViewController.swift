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
        unsentItems = receipt.items
    }
    
    
    //    MARK: - Private
    
    private var receipt = DataSource.receipt
    
    private var unsentItems = [ReceiptItem]()
    private var sentItems = [ReceiptItem]()
    
    private var selectedIndexes = Set<Int>() {
        didSet {
            if selectedIndexes.count == 0 {
                requestButton.disable()
            } else {
                requestButton.enable()
            }
        }
    }
    
    private let personPortraitCellId = "personPortraitCellId"
    
    private var tableView = UITableView()
    private let selectItemTableViewCellId = "selectItemTableViewCellId"
    
    private let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkBlue
        return view
    }()
    
    private let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Request", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(requestButtonTapped(sender: )), for: UIControlEvents.touchDown)
        button.disable()
        return button
    }()
    
    private func addSubviews() {
        [tableView, actionView].forEach { (view) in
            self.view.addSubview(view)
        }
        
        [requestButton].forEach { (view) in
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
        
        requestButton.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        self.title = "Select Items"
        self.view.backgroundColor = AppColors.white
        setUpTableView()
        addSubviews()
        setConstraints()
    }
    
    @objc private func requestButtonTapped(sender: UIButton) {
        var items = [ReceiptItem]()
        for index in selectedIndexes {
            items.append(unsentItems[index])
        }
        navigationController?.pushViewController(RequestMoneyViewController(items: items, delegate: self), animated: true)
    }
    
    private func setUpTableView() {
        tableView.register(SelectItemTableViewCell.self, forCellReuseIdentifier: selectItemTableViewCellId)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SelectItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return unsentItems.count
        case 1:
            return sentItems.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: selectItemTableViewCellId, for: indexPath) as! SelectItemTableViewCell
        switch indexPath.section {
        case 0:
            cell.setUp(indexPath: indexPath, delegate: self, receiptItem: unsentItems[indexPath.row])
        case 1:
            cell.setUp(indexPath: indexPath, delegate: self, receiptItem: sentItems[indexPath.row])
        default: break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
//        case 0:
//            return "Unsent Items"
        case 1:
            return "Sent Items"
        default:
            return nil
        }
    }
}

extension SelectItemsViewController: CellTapDelegate {
//    This is a replacement for tableview(did select row at)
//    We only want to trigger it when a view is tap, and not the whole cell
    func cellWasTapped(indexPath: IndexPath) {
        if indexPath.section == 0 {
            if selectedIndexes.contains(indexPath.row) {
                selectedIndexes.remove(indexPath.row)
            } else {
                selectedIndexes.insert(indexPath.row)
            }
        }
    }
}

extension SelectItemsViewController: RequestMoneyDelegate {
    func confirmButtonPressed() {
        var indexArray = [Int]()
        for index in selectedIndexes {
            sentItems.append(unsentItems[index])
            indexArray.append(index)
        }
        indexArray = indexArray.sorted().reversed()
        for index in indexArray {
            unsentItems.remove(at: index)
        }
        
        selectedIndexes = []
        tableView.reloadData()

    }
    
    
}
