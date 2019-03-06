//
//  InvitePeopleTableViewCell.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class InviteTableViewCell: UITableViewCell {
    
    func setUp() {
        addSubviews()
        setConstraints()
        
        portraitImageView.layer.cornerRadius = (self.frame.height - 32) / 2
        
        portraitImageView.image = #imageLiteral(resourceName: "IMG_0932")
        fullNameLabel.text = "Tony Cioara"
        usernameLabel.text = "@Tony-Cioara"
        
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
    
    private let inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Invite", for: .normal)
        button.titleLabel?.font = AppFonts.regular14
        button.backgroundColor = AppColors.veryBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(inviteButtonClicked(sender:)), for: .touchDown)
        return button
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Light - Info"), for: .normal)
        button.addTarget(self, action: #selector(infoButtonClicked(sender:)), for: .touchDown)
        return button
    }()
    
    private func addSubviews() {
        [portraitImageView, fullNameLabel, usernameLabel, bottomView, infoButton, inviteButton].forEach { (view) in
            self.addSubview(view)
        }
    }
    
    private func setConstraints() {
        portraitImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().inset(16)
            make.height.equalTo(portraitImageView.snp.width)
        }
        
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(portraitImageView.snp.top)
            make.left.equalTo(portraitImageView.snp.right).offset(8)
            make.right.greaterThanOrEqualTo(inviteButton.snp.left).inset(16)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(2)
            make.left.equalTo(fullNameLabel.snp.left)
            make.right.greaterThanOrEqualTo(inviteButton.snp.left).inset(16)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview().inset(32)
        }
        
        infoButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview().inset(16)
            make.width.equalTo(infoButton.snp.height)
        }
        
        inviteButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.right.equalTo(infoButton.snp.left)
        }
    }
    
    @objc private func infoButtonClicked(sender: UIButton) {
        
    }
    
    @objc private func inviteButtonClicked(sender: UIButton) {
        
    }
}
