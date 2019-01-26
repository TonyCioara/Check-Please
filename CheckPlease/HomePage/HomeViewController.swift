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
import SwiftyJSON

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpViews()
    }
    
    //    MARK: - Private
    
    private var receipts = [Receipt]()
    
    private let fullReceiptCellId = "fullReceiptCellId"
    private let cameraButtonCellId = "cameraButtonCellId"
    
    private let tableView = UITableView()
    
    private func setUpData() {
//        var receipt = DataSource.receipt
//        receipt.items = [DataSource.receiptItem1, DataSource.receiptItem2, DataSource.receiptItem3, DataSource.receiptItem4, DataSource.receiptItem5]
//
//        for _ in 1...5 {
//            receipts.append(receipt)
//        }
//
        guard let userId = User.getId() else {print("User Id not found"); return}
//        CheckPleaseAPI.getUserReceipts(withUserId: userId) { (dict, res, err) in
//            if let err = err {
//                print(err)
//                return
//            }
//            guard let dict = dict else {print("no JSON Found"); return}
//            print(dict["data"])
//        }
    }
    
    private func addSubviews() {
        [tableView].forEach { (view) in
            self.view.addSubview(view)
        }
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        self.title = "Past Receipts"
        self.view.backgroundColor = AppColors.white
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        button.setImage(#imageLiteral(resourceName: "smallCameraIcon"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonTapped(sender:)), for: .touchDown)
        let rightItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
        addSubviews()
        setConstraints()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(FullReceiptCell.self, forCellReuseIdentifier: fullReceiptCellId)
        tableView.register(CameraButtonCell.self, forCellReuseIdentifier: cameraButtonCellId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func rightBarButtonTapped(sender: UIBarButtonItem) {
        navigationController?.pushViewController(TakePhotoViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, CellTapDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if receipts.count == 0 {
            return 1
        }
        return receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if receipts.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cameraButtonCellId, for: indexPath) as! CameraButtonCell
            cell.setUp()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: fullReceiptCellId, for: indexPath) as! FullReceiptCell
        cell.setUp(indexPath: indexPath, delegate: self, receipt: receipts[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if receipts.count == 0 {
            return self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0)
        }
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TakePhotoViewController(), animated: true)
    }
    func cellWasTapped(indexPath: IndexPath) {
        navigationController?.pushViewController(ReceiptDetailsViewController(), animated: true)
    }
}
