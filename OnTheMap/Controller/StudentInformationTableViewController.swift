//
//  StudentInformationTableViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 19.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class StudentInformationTableViewController: UITableViewController {
    
    var studentInformationTableViewDelegate = StudentInformationTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self.studentInformationTableViewDelegate
        self.tableView.dataSource = self.studentInformationTableViewDelegate
    }
}
