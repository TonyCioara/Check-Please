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
                    nextButton.disable()
                } else {
                    inputTextField.text = text
                    nextButton.enable()
                }
            } else {
                inputTextField.text = ""
                nextButton.disable()
            }
            // Only enable backButton after first entry is accepted
            if step > 0 {
                backButton.enable()
            } else {
                backButton.disable()
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = .white
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: Methods
    
    private func addSubviews() {
        nextButton.addSubview(activityIndicator)
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
        
        activityIndicator.snp.makeConstraints { make in
            // Superview is nextButton
            make.center.equalToSuperview()
        }
    }
    
    private func showActivityIndicator() {
        nextButton.setTitle("", for: .normal)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        backButton.disable()
    }
    
    private func hideActivityIndicator() {
        nextButton.setTitle("Sign Up", for: .normal)
        activityIndicator.stopAnimating()
    }
    
    @objc private func nextButtonTapped(sender: UIButton) {
        guard let text = inputTextField.text else {return}
        userDict[dictKeyArray[step]] = text
        
        guard step == labelTextArray.count - 1 else {
            step += 1
            return
        }
        showActivityIndicator()
        CheckPleaseAPI.signUp(withUserObject: userDict) { (json, response, err) in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
            }
            guard let httpURLResponse = response as? HTTPURLResponse,
                let json = json else {
                    print("\n * signUpViewController -> nextButtonTapped(sender:) = Invalid httpURLResponse or json")
                    self.presentDefaultErrorAlertOnMainThread()
                    return
            }
            
            if httpURLResponse.statusCode == 200 {
                guard let userData = json["data"] as? [String: String],
                    let user = User(json: userData) else {
                        print("\n * SignUpViewController -> loginButtonTapped(sender:) = Invalid httpURLResponse or json")
                        self.presentDefaultErrorAlertOnMainThread()
                        return
                }
                user.cache()
                print(" \n * Successful sign up for user with info:\n \(user.description)")
                DispatchQueue.main.async {
                    let navController = UINavigationController(rootViewController: HomeViewController())
                    navController.navigationBar.prefersLargeTitles = true
                    navController.navigationBar.barTintColor = AppColors.white
                    self.present(navController, animated: true)
                }
                // Return prevents attempt to present alert controllers bellow.
                return
            }
            
            guard let errorData = json["messages"] as? [String],
                let message = errorData.first else {
                    self.presentDefaultErrorAlertOnMainThread()
                    return
            }
            DispatchQueue.main.async {
                self.presentOKAlert(withTitle: message, message: nil)
            }
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text?.isEmptyOrWhitespace)! {
            nextButton.disable()
        } else {
            nextButton.enable()
        }
    }
}
