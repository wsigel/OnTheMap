//
//  StudentLocationTableViewDelegate.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 19.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class StudentInformationTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
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
        let studentInformation = StudentCollection.students[indexPath.row] as StudentInformation
        DispatchQueue.main.async {
            UIApplication.shared.open(URL(string: studentInformation.mediaURL)!, options: [:], completionHandler: nil)
        }
    }
}
