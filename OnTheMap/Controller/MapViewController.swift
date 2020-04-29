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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var annotations = [MKPointAnnotation]()
    
    //var studentInformationMapViewDelgate: MKMapViewDelegate? = StudentInformationMapViewDelegate()
    var studentInformationMapViewDelgate: MKMapViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentInformationMapViewDelgate = StudentInformationMapViewDelegate(viewcontroller: self)
        self.mapView.delegate = studentInformationMapViewDelgate
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name:  Notification.Name.RefreshData, object: nil)
        if !AppDelegate.isNetworkAvailable() {
            ErrorAlertController.showAlertController(parent: self, title: "Network Connectivity", message: "There is no network available to facilitate the retrieval of student locations")
            return
        }
        DispatchQueue.main.async {
            self.showActivityIndicator(searching: true)
        }
        UdacityClient.getStudentLocations(completion: handleStudentRequest(students:error:))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.RefreshData, object: nil)
    }
    
    @objc func refreshData(){
        DispatchQueue.main.async {
            self.showActivityIndicator(searching: true)
        }
        self.annotations = []
        UdacityClient.getStudentLocations(completion: handleStudentRequest(students:error:))
    }
    
    func showActivityIndicator(searching: Bool) {
        if searching {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func handleStudentRequest(students: StudentRequest?, error: Error?){
        DispatchQueue.main.async {
            self.showActivityIndicator(searching: false)
        }
        if error != nil {
            ErrorAlertController.showAlertController(parent: self, title: "Retrieval failure", message: "An error occured getting student locations")
        } else {
            if let students = students {
                StudentCollection.students = students.results
                getStudentInformation()
                self.mapView.addAnnotations(self.annotations)
            }
        }
    }
    
    
    func getStudentInformation() -> Void {
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
    }
}
