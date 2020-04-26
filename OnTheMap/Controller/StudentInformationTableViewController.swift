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
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name.init(rawValue: "RefreshData"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    func handleRefreshResponse(students: StudentRequest?, error: Error?){
        if error != nil {
            showRetrievalFailure(message: "Error retrieving Student Locations")
        } else {
            if let students = students {
                StudentCollection.students.removeAll()
                StudentCollection.students = students.results
                tableView.reloadData()
            }
        }
    }
    
    func showRetrievalFailure(message: String) {
        let alertVC = UIAlertController(title: "Retrieval failure", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    @objc func refreshData(){
        OnTheMapClient.getStudentLocations(completion: handleRefreshResponse(students:error:))
        print("refresh from tableviewcontroller")
    }
}
