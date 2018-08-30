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
    
    //    MARK: UI
    let personReceiptCellId = "personReceiptCellId"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PreviousReceiptCell.self, forCellReuseIdentifier: "personReceiptCellId")
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
        self.title = "Receipt Details"
        addSubviews()
        setConstraints()
        setUpTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

extension ReceiptDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: personReceiptCellId, for: indexPath) as! PreviousReceiptCell
        cell.setUp()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
