//
//  UIViewControllerExtensions.swift
//  CheckPlease
//
//  Created by Erik Perez on 11/26/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Presents Alert with single 'OK' action.
    func presentOKAlert(withTitle title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// Presents alert with single 'OK' action and default error message. Best used for unexpected errors during
    /// network requests.
    func presentDefaultErrorAlertOnMainThread() {
        DispatchQueue.main.async {
            let defaultErrorMessage = "Something went wrong on our end. Please try again later"
            self.presentOKAlert(withTitle: "Oops", message: defaultErrorMessage)
        }
    }
}
