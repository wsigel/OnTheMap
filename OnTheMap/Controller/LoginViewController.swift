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
        UIApplication.shared.open(OnTheMapClient.Endpoints.signUpUdacity.url, options: [:], completionHandler: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.setLoggingIn(true)
        }
        
        let body = SessionRequest(udacity: Credentials(username: loginTextField.text ?? "", password: passwordTextField.text ?? ""))
        OnTheMapClient.login(body: body, completion: handleRequestSessionResponse(success:error:))
        setLoggingIn(false)
    }
    
    func handleRequestSessionResponse(success: Bool, error: Error?) {
        DispatchQueue.main.async {
            self.setLoggingIn(false)
        }
        if error != nil {
            if let error = error as? UdacityResponse {
                let ac = ErrorAlertController.createAlertController(title: "Login failure", message: error.localizedDescription)
                self.present(ac, animated: true)
            }
        }
        else {
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
