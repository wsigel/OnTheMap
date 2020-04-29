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
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: self, title: "Network Connectivity", message: "There is no network available to refresh student locations")
            return
        }
        NotificationCenter.default.post(name: Notification.Name.RefreshData, object: nil)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: self, title: "Network Connectivity", message: "There is no network available to facilitate the logout request")
            return
        }
        UdacityClient.deleteSession(completion: handleDeleteSessionResponse(response:error:))
    }
    
    func handleDeleteSessionResponse(response: LogoutResponse?, error: Error?) -> Void {
        if error != nil {
            ErrorAlertController.showAlertController(parent: self, title: "Logout failure", message: "An error was encountered when closing the session")
        } else {
            dismiss(animated: true) {
                UdacityClient.Auth.sessionId = ""
                UdacityClient.Auth.registered = false
                UdacityClient.Auth.key = ""
                UdacityClient.Auth.expiration = ""
            }
        }
    }
}
 
