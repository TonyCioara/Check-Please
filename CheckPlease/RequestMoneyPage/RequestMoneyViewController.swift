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
    
    //    MARK: - Private
    
//  Change this to users once connected to the backend.
    private var filteredPhoneNumbers = [String]()
    private var phoneNumbers: [String] = ["9712810024", "43243243431", "576767653", "971824512", "099933321"]
    
    private let users = DataSource.users
    private var filteredUsers = [User]()
    
    private let searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.keyboardType = .numberPad
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "phone"
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
}

extension RequestMoneyViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        filterContentWhenSearching(_searchText: text)
    }
    
    //    MARK: - Private
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentWhenSearching(_searchText: String, scope: String = "All") {
        filteredUsers = users.filter({ (user) -> Bool in
            if user.firstName.contains(_searchText) ||
                    user.lastName.contains(_searchText) ||
                    user.email.contains(_searchText) ||
                    user.phoneNumber.contains(_searchText) {
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
