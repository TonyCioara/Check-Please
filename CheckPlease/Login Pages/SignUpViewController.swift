//
//  SignUpViewController2.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    let labelTextArray = ["Email", "First Name", "Last Name", "Password", "Phone number"]
    let dictKeyArray = ["email", "first_name", "last_name", "password", "phone_number"]
    
    var resultsDict: [String: String] = ["payment_method": "Card"]
    
    var step: Int = 0 {
        didSet {
            inputTypeLabel.text = labelTextArray[step]
        }
    }
    
    let inputTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.white
        label.font = AppFonts.bold22
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.white
        textField.font = AppFonts.regular14
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  AppColors.darkBlue
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Next", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(nextButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    let oldUserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppFonts.medium18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Already signed up?", for: UIControlState.normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(oldUserButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    func addSubviews() {
        [signUpButton, oldUserButton, inputTypeLabel, inputTextField].forEach { (view) in
            self.view.addSubview(view)
        }
    }
    
    func setConstraints() {
        inputTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.right.left.equalToSuperview().inset(32)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.top.equalTo(inputTypeLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(inputTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        oldUserButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
            make.right.equalTo(signUpButton.snp.right)
        }
    }
    
    override func viewDidLoad() {
        step = 0
        self.view.backgroundColor = AppColors.mediumBlue
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        setConstraints()
    }
    
    @objc func nextButtonTapped(sender: UIButton) {
        
        guard let text = inputTextField.text else {return}
        resultsDict[dictKeyArray[step]] = text
        if step == labelTextArray.count - 1 {
            Networking.fetch(route: .signUp(userDict: self.resultsDict)) { (data) in
                print(JSON(data))
            }
        } else {
            inputTextField.text = ""
            step += 1
        }
    }
    
    @objc func oldUserButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
