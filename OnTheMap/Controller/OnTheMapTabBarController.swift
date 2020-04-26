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
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("RefreshData"), object: nil)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        OnTheMapClient.deleteSession(completion: handleDeleteSessionResponse(response:error:))
    }
    
    func handleDeleteSessionResponse(response: LogoutResponse?, error: Error?) -> Void {
        if error != nil {
            let ac = ErrorAlertController.createAlertController(title: "Logout failure", message: "An error was encountered when closing the session")
        } else {
            dismiss(animated: true) {
                OnTheMapClient.Auth.sessionId = ""
                OnTheMapClient.Auth.registered = false
                OnTheMapClient.Auth.key = ""
                OnTheMapClient.Auth.expiration = ""
            }
        }
    }
}
 
