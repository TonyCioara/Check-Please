//
//  RequestTableViewCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/5/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RequestTableViewCell: UITableViewCell {
    
    func setUp(user: User) {
        addSubviews()
        setConstraints()
        
        portraitImageView.layer.cornerRadius = (self.frame.height - 32) / 2
        
        portraitImageView.image = #imageLiteral(resourceName: "IMG_0932")
        fullNameLabel.text = user.firstName + " " + user.lastName
        usernameLabel.text = user.phoneNumber
        
    }
    
    //    MARK: - Private
    private let portraitImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.borderColor = AppColors.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.semibold18
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.light12
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        return view
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Light - Info"), for: .normal)
        button.addTarget(self, action: #selector(infoButtonClicked(sender:)), for: .touchDown)
        return button
    }()
    
    private func addSubviews() {
        [fullNameLabel, usernameLabel, bottomView].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
//        portraitImageView.snp.makeConstraints { (make) in
//            make.left.top.bottom.equalToSuperview().inset(16)
//            make.height.equalTo(portraitImageView.snp.width)
//        }
        
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(16)
            make.right.greaterThanOrEqualToSuperview().inset(16)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(2)
            make.left.equalTo(fullNameLabel.snp.left)
            make.right.greaterThanOrEqualToSuperview().inset(16)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview().inset(32)
        }
        
//        infoButton.snp.makeConstraints { (make) in
//            make.top.bottom.right.equalToSuperview().inset(16)
//            make.width.equalTo(infoButton.snp.height)
//        }
    }
    
    @objc private func infoButtonClicked(sender: UIButton) {
        
    }
}
