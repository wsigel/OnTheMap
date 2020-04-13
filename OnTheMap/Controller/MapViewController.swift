//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 13.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
     
    @IBOutlet weak var mapView: MKMapView!
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnTheMapClient.getStudentLocations(completion: handleStudentRequest(students:error:))
        
    }
    
    func handleStudentRequest(students: StudentRequest?, error: Error?){
        if error != nil {
            // show error message
        } else {
            if let students = students?.results {
                self.students = students
            }
        }
    }
}
