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
        dismiss(animated: true) {
            OnTheMapClient.Auth.sessionId = ""
            OnTheMapClient.Auth.registered = false
            OnTheMapClient.Auth.key = ""
            OnTheMapClient.Auth.expiration = ""
        }
    }
}
 
