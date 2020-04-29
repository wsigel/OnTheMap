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
    
    
    var studentInformationTableViewDelegate: StudentInformationTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentInformationTableViewDelegate = StudentInformationTableViewDelegate(parent: self)
        self.tableView.delegate = self.studentInformationTableViewDelegate
        self.tableView.dataSource = self.studentInformationTableViewDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name.RefreshData, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.RefreshData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func refreshData(){
        UdacityClient.getStudentLocations(completion: handleRefreshResponse(students:error:))
    }
    
    func handleRefreshResponse(students: StudentRequest?, error: Error?){
        if error != nil {
            ErrorAlertController.showAlertController(parent: self, title: "Retrieval failure", message: "An error occured while refreshing student locations")
        } else {
            if let students = students {
                StudentCollection.students.removeAll()
                StudentCollection.students = students.results
                tableView.reloadData()
            }
        }
    }
}
