//
//  SignUpViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    //    MARK: UI
    
    let scrollView = UIScrollView()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let retypePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Retype Password"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "First Name"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Last Name"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Phone Number"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.bold48
        label.text = "CHECK PLEASE"
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  AppColors.darkBlue
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Login", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    let oldUserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppFonts.medium18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Already signed up?", for: UIControlState.normal)
        button.addTarget(self, action: #selector(oldUserButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradientLayer.colors = [AppColors.white.cgColor, AppColors.mediumBlue.cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
    func addSubviews() {
        addGradient()
        self.view.addSubview(scrollView)
        [emailTextField, usernameTextField, firstNameTextField, lastNameTextField, passwordTextField, retypePasswordTextField, phoneNumberTextField, titleLabel, signUpButton, oldUserButton].forEach { (view) in
            scrollView.addSubview(view)
        }
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo((view.safeAreaLayoutGuide.snp.top))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.width.equalToSuperview().offset(-64)
            make.height.equalTo(200)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        firstNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        lastNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        phoneNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        retypePasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(retypePasswordTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        oldUserButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
            make.right.equalTo(signUpButton.snp.right)
            make.width.equalTo(180)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    func setUpViews() {
        navigationController?.isNavigationBarHidden = true
        
        [emailTextField, usernameTextField, firstNameTextField, lastNameTextField, passwordTextField, phoneNumberTextField, retypePasswordTextField].forEach { (textField) in
            textField.setLeftPaddingPoints(16)
            textField.setRightPaddingPoints(16)
        }
        addSubviews()
        setConstraints()
        
    }
    
    //    MARK: Functionality
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    @objc func signUpButtonTapped(sender: UIButton) {
        guard let email = emailTextField.text,
            let username = usernameTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let password = passwordTextField.text,
            let retypePassword = retypePasswordTextField.text,
            let phoneNumber = phoneNumberTextField.text
            else {return}
        if password != retypePassword {
            let alert = UIAlertController(title: "The password was not retyped correctly", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            return
        }
    }
    
    @objc func oldUserButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
