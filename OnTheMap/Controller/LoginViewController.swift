//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 06.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: ViewController {
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        let body = SessionRequest(udacity: Credentials(username: loginTextField.text ?? "", password: passwordTextField.text ?? ""))
        OnTheMapClient.login(body: body, completion: handleRequestSessionResponse(response:error:))
        setLoggingIn(false)
    }
    
    func handleRequestSessionResponse(response: SessionResponse?, error: Error?) {
        setLoggingIn(false)
        if error != nil {
            if let error = error as? UdacityResponse {
                showLoginFailure(message: error.localizedDescription)
            }
        }
        else {
            // navigate to next screen
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login failure", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    
    func setLoggingIn(_ loggingIn: Bool){
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}
