//
//  OnTheMapTabBarController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 19.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class OnTheMapTabBarController: UITabBarController {
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        OnTheMapClient.deleteSession(completion: handleDeleteSessionResponse(response:error:))
    }
    
    func handleDeleteSessionResponse(response: LogoutResponse?, error: Error?) -> Void {
        if error != nil {
            showLogoutFailure()
        } else {
            dismiss(animated: true) {
                OnTheMapClient.Auth.sessionId = ""
                OnTheMapClient.Auth.registered = false
                OnTheMapClient.Auth.key = ""
                OnTheMapClient.Auth.expiration = ""
            }
        }
    }
    
    func showLogoutFailure() {
        let alertVC = UIAlertController(title: "Logout failure", message: "Error encountered on deleting the session", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
 
