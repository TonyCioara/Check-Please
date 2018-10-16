//
//  RequestMoneyViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RequestMoneyViewController: UIViewController {
 //        TODO: Add search by name and email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        searchController.searchResultsUpdater = self
        
    }
    
    init(items: [ReceiptItem], delegate: RequestMoneyDelegate) {
        
        self.receiptItems = items
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Private
    
    private var delegate: RequestMoneyDelegate!
//  Change this to users once connected to the backend.
    
    private let users = DataSource.users
    private var filteredUsers = [User]()
    
    private var receiptItems: [ReceiptItem]
    
    private let searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.keyboardType = .numberPad
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Name, e-mail, phone"
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    private let tableView = UITableView()
    private let requestTableViewCellId = "requestTableViewCellId"
    
    private func addSubviews() {
        [tableView].forEach { (view) in
            self.view.addSubview(view)
        }
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.bottom.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        self.title = "Request"
        self.view.backgroundColor = AppColors.white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        addSubviews()
        setConstraints()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: requestTableViewCellId)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func displayAlert(user: User) {
        var message = "Items: "
        for index in 0..<receiptItems.count {
            let item = receiptItems[index]
            if index == receiptItems.count - 1 {
                message.append(item.name)
            } else {
                message.append("\(item.name), ")
            }
            
        }
        
        let alertController = UIAlertController(title: "Request \(user.firstName) \(user.lastName)", message: message, preferredStyle: .actionSheet)
        
        let actionOne = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //            TODO: Perform networking request here
            self.delegate.confirmButtonPressed()
            self.navigationController?.popViewController(animated: true)
        }
        
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        
        if isFiltering() {
            searchController.present(alertController, animated: true, completion: nil)
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}

extension RequestMoneyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: requestTableViewCellId, for: indexPath) as! RequestTableViewCell
        if isFiltering() {
            cell.setUp(user: filteredUsers[indexPath.row])
        } else {
            cell.setUp(user: users[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser: User
        if isFiltering() {
            selectedUser = filteredUsers[indexPath.row]
        } else {
            selectedUser = users[indexPath.row]
        }
        
//        searchController.isActive = false
        displayAlert(user: selectedUser)
    }
}

extension RequestMoneyViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        filterContentWhenSearching(searchText: text)
    }
    
    //    MARK: - Private
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentWhenSearching(searchText: String, scope: String = "All") {
        filteredUsers = users.filter({ (user) -> Bool in
            if user.firstName.contains(searchText) ||
                    user.lastName.contains(searchText) ||
                    user.email.contains(searchText) ||
                    user.phoneNumber.contains(searchText) {
                return true
            }
            return false
        })
        
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}
