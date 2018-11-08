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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //    MARK: - Private
    private let scrollView = UIScrollView()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = AppFonts.regular14
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.white
        label.font = AppFonts.bold48
        label.text = "CHECK PLEASE"
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  AppColors.darkBlue
        button.titleLabel?.font = AppFonts.bold18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("Login", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    private let newUserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = AppFonts.medium18
        button.titleLabel?.textColor = AppColors.white
        button.setTitle("I'm New", for: UIControlState.normal)
        button.addTarget(self, action: #selector(newUserButtonTapped(sender:)), for: UIControlEvents.touchDown)
        
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = .white
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: Methods
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradientLayer.colors = [AppColors.white.cgColor, AppColors.mediumBlue.cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func addSubviews() {
        self.view.backgroundColor = AppColors.mediumBlue
        self.view.addSubview(scrollView)
        loginButton.addSubview(activityIndicator)
        [emailTextField, passwordTextField, titleLabel, loginButton, newUserButton].forEach { (view) in
            scrollView.addSubview(view)
        }
        
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo((view.safeAreaLayoutGuide.snp.top))
            make.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
            make.width.equalTo(self.view.snp.width).offset(-64)
            make.height.equalTo(200)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        newUserButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.right.equalTo(loginButton.snp.right)
            make.width.equalTo(85)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        activityIndicator.snp.makeConstraints { maker in
            // Superview is loginButton
            maker.center.equalToSuperview()
        }
        
    }
    
    private func setUpViews() {
        navigationController?.isNavigationBarHidden = true
        addSubviews()
        setConstraints()
    }
    
    private func showActivityIndicator() {
        loginButton.setTitle("", for: .normal)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        loginButton.setTitle("Login", for: .normal)
        activityIndicator.stopAnimating()
    }
    
    @objc private func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc private func loginButtonTapped(sender: UIButton) {
        // TODO: Add loading icon
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        CheckPleaseAPI.login(withEmail: email, password: password) { (json, err) in
            // TODO: Cache user info after successful login
            if let _ = err {
                return
            }
            
            guard let jsonDict = json else {return}
            
            let user = User(json: jsonDict)
            
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: HomeViewController())
                navController.navigationBar.prefersLargeTitles = true
                navController.navigationBar.barTintColor = AppColors.white
                self.present(navController, animated: true)
                
            }
        }
    }
    
    @objc private func newUserButtonTapped(sender: UIButton) {
        
        let signUpVC = SignUpViewController()
        self.present(signUpVC, animated: true)
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        // Check for valid entries in both textfields in order to enable 'login' button
        let isEmailFieldTextValid = emailTextField.text != nil && !emailTextField.text!.isEmptyOrWhitespace
        let isPasswordFieldTextValid = passwordTextField.text != nil && !passwordTextField.text!.isEmptyOrWhitespace
        guard isEmailFieldTextValid && isPasswordFieldTextValid else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
            return
        }
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
    }
}
