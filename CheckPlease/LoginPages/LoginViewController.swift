//
//  ViewController.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
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
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  AppColors.darkBlue
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Login", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    let newUserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppFonts.medium18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("I'm New", for: UIControlState.normal)
        button.addTarget(self, action: #selector(newUserButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
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
        [emailTextField, passwordTextField, titleLabel, loginButton, newUserButton].forEach { (view) in
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
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        newUserButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.right.equalTo(loginButton.snp.right)
            make.width.equalTo(85)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    func setUpViews() {
        navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        setConstraints()
        
    }
    
    //    MARK: Functionality
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    @objc func loginButtonTapped(sender: UIButton) {
        
    }
    
    @objc func newUserButtonTapped(sender: UIButton) {
        
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}

