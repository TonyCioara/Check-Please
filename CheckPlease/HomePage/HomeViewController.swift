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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //    MARK: - Private
    
    private let fullReceiptCellId = "fullReceiptCellId"
    
    private let tableView = UITableView()
    
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
        let button = UIButton(frame: CGRect(x: 0, y: 10, width: 48, height: 48))
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
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func rightBarButtonTapped(sender: UIBarButtonItem) {
        print("abcd")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, CellTapDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: fullReceiptCellId, for: indexPath) as! FullReceiptCell
        cell.setUp(indexPath: indexPath, delegate: self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func cellWasTapped(indexPath: IndexPath) {
        navigationController?.pushViewController(ReceiptDetailsViewController(), animated: true)
    }
}
