//
//  StudentLocationTableViewDelegate.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 19.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

// MARK: used by StudentInformationTableViewController

class StudentInformationTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let parent: StudentInformationTableViewController?
    
    init(parent: StudentInformationTableViewController) {
        self.parent = parent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentCollection.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentInformationCell")
        let studentInformation = StudentCollection.students[indexPath.row]
        cell?.imageView?.image = UIImage(named: "icon_pin")
        cell?.textLabel?.text = studentInformation.firstName + " " + studentInformation.lastName
        cell?.detailTextLabel?.text = studentInformation.mediaURL
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let parent = self.parent else {
            return
        }
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: parent, title:  "Network Connectivity", message: "The is no network connection available to access the URL")
            return
        }
        let studentInformation = StudentCollection.students[indexPath.row] as StudentInformation
        DispatchQueue.main.async {
            UIApplication.shared.open(URL(string: studentInformation.mediaURL)!, options: [:], completionHandler: nil)
        }
    }
}
