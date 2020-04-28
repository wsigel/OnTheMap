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
    
    class func showAlertController(parent: UIViewController, title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        parent.present(alertVC, animated: true, completion: nil)
    }
}
