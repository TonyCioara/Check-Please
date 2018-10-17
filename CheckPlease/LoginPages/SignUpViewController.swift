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
    
    override func viewDidLoad() {
        step = 0
        self.view.backgroundColor = AppColors.mediumBlue
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        setConstraints()
        // Present keyboard at instantiation of controller
        inputTextField.becomeFirstResponder()
    }
    
    //    MARK: - Private
    
    private let labelTextArray = ["Email", "First Name", "Last Name", "Password", "Phone number"]
    private let dictKeyArray = ["email", "firstName", "lastName", "password", "phoneNumber"]
    
    private var userDict: [String: String] = [:]
    
    private var step: Int = 0 {
        didSet {
            inputTypeLabel.text = labelTextArray[step]
            // If we get to the last step change the text of the next button
            if step == dictKeyArray.count - 1 {
                nextButton.setTitle("Sign Up", for: .normal)
                inputTextField.keyboardType = .numberPad
            } else {
                nextButton.setTitle("Next", for: .normal)
                inputTextField.keyboardType = .default
            }
            // If it's the password make it hidden
            if dictKeyArray[step] == "password" {
                inputTextField.isSecureTextEntry = true
            } else {
                inputTextField.isSecureTextEntry = false
            }
            // If user has already added this field show the progress
            if let text = userDict[dictKeyArray[step]] {
                if text.isEmptyOrWhitespace {
                    inputTextField.text = ""
                    disableNextButton()
                } else {
                    inputTextField.text = text
                    enableNextButton()
                }
            } else {
                inputTextField.text = ""
                disableNextButton()
            }
            // Only enable backButton after first entry is accepted
            if step > 0 {
                backButton.backgroundColor = .clear
                // This alpha affects the buttons title label
                backButton.alpha = 1.0
                backButton.isEnabled = true
            } else {
                backButton.backgroundColor = AppColors.black.withAlphaComponent(0.3)
                // This alpha affects the buttons title label
                backButton.alpha = 0.5
                backButton.isEnabled = false
            }
        }
    }
    
    private let inputTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.white
        label.font = AppFonts.bold22
        return label
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.white
        textField.font = AppFonts.regular14
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: UIControlEvents.editingChanged)
        return textField
    }()
    
    private let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let actionViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.white
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(backButtonTapped(sender:)), for: UIControlEvents.touchDown)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.addTarget(self, action: #selector(nextButtonTapped(sender:)), for: UIControlEvents.touchDown)
        return button
    }()
    
    private let oldUserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppFonts.medium18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Already signed up?", for: UIControlState.normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(oldUserButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    // MARK: Methods
    
    private func addSubviews() {
        [actionView, oldUserButton, inputTypeLabel, inputTextField].forEach { (view) in
            self.view.addSubview(view)
        }
        [backButton, nextButton, actionViewSeparator].forEach { (view) in
            self.actionView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        inputTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.right.left.equalToSuperview().inset(32)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.top.equalTo(inputTypeLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        actionView.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(inputTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        oldUserButton.snp.makeConstraints { (make) in
            make.top.equalTo(actionView.snp.bottom).offset(8)
            make.right.equalTo(actionView.snp.right)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(nextButton.snp.left)
        }
        
        actionViewSeparator.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(2)
            make.right.equalTo(nextButton.snp.left)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(backButton).multipliedBy(4)
        }
    }
    
    private func enableNextButton() {
        nextButton.backgroundColor = .clear
        nextButton.alpha = 1.0
        nextButton.isEnabled = true
    }
    
    private func disableNextButton() {
        nextButton.backgroundColor = AppColors.black.withAlphaComponent(0.3)
        nextButton.alpha = 0.5
        nextButton.isEnabled = false
    }
    
    @objc private func nextButtonTapped(sender: UIButton) {
        guard let text = inputTextField.text else {return}
        userDict[dictKeyArray[step]] = text
        if step == labelTextArray.count - 1 {
            // TODO: Cache user info after successful sign up
            CheckPleaseAPI.signUp(withUserObject: userDict) { (json, err) in
                // TODO: Implement closure body
            }
        } else {
            step += 1
        }
    }
    
    @objc private func backButtonTapped(sender: UIButton) {
        guard let text = inputTextField.text else {return}
        userDict[dictKeyArray[step]] = text
        if step > 0 {
            step -= 1
        }
    }
    
    @objc private func oldUserButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text?.isEmptyOrWhitespace)! {
            disableNextButton()
        } else {
            enableNextButton()
        }
    }
}
