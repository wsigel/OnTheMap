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
    var annotations = [MKPointAnnotation]()
    
    var studentLocationMapViewDelgate: MKMapViewDelegate = StudentLocationMapViewDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnTheMapClient.getStudentLocations(completion: handleStudentRequest(students:error:))
        self.mapView.delegate = studentLocationMapViewDelgate
        //getStudentInformation()
        
        
    }
    
    func handleStudentRequest(students: StudentRequest?, error: Error?){
        if error != nil {
            // show error message
        } else {
            if let students = students {
                StudentCollection.students = students.results
                getStudentInformation()
                self.mapView.addAnnotations(self.annotations)
            }
        }
    }
    
    func getStudentInformation() -> Void {
        print("Studenten: \(StudentCollection.students.count)")
        for student in StudentCollection.students {
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName
            let last = student.lastName
            let mediaURL = student.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            self.annotations.append(annotation)
        }
        print("Anzahl: \(annotations.count)")
    }
}
