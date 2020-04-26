//
//  ErrorAlertController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 26.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlertController {
    class func createAlertController(title: String, message: String) -> UIAlertController{
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertVC
    }
}
