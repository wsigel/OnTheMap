//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 06.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: self, title: "Network Connectivity", message: "There is no network available to facilitate the sign up request")
            return
        }
        UIApplication.shared.open(UdacityClient.Endpoints.signUpUdacity.url, options: [:], completionHandler: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: self, title: "Network Connectivity", message: "There is no network available to facilitate the login request")
            return
        }
        DispatchQueue.main.async {
            self.setLoggingIn(true)
        }
        
        guard let username = loginTextField.text, let password = passwordTextField.text else {
            return
        }
        
        if username == "" || password == "" {
            ErrorAlertController.showAlertController(parent: self, title: "Missing Credentials", message: "Login and password are mandatory")
            DispatchQueue.main.async {
                self.setLoggingIn(false)
            }
            return
        }
        let body = SessionRequest(udacity: Credentials(username: username, password: password))
        UdacityClient.login(body: body, completion: handleRequestSessionResponse(success:error:))
    }
    
    func handleRequestSessionResponse(success: Bool, error: Error?) {
        DispatchQueue.main.async {
            self.setLoggingIn(false)
        }
        if error != nil {
            if let error = error as? UdacityResponse {
                ErrorAlertController.showAlertController(parent: self, title: "Login failure", message: error.localizedDescription)
            }
        }
        else {
            self.passwordTextField.text = ""
            self.loginTextField.text = ""
            self.loginTextField.becomeFirstResponder()
            performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    
    
    func setLoggingIn(_ loggingIn: Bool){
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}
