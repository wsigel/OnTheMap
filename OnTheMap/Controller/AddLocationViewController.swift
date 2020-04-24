//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 15.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addLocationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var addLocationMapView: MKMapView!
    
    var locationCoordinates: CLLocationCoordinate2D?
    var addLocationMapViewDelegate: AddLocationMapViewDelegate = AddLocationMapViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLocationMapView.delegate = addLocationMapViewDelegate
        displayMap(showing: false)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        if let studentInformation = createStudentInformation() {
            OnTheMapClient.createStudentLocation(studentInformation: studentInformation, url: OnTheMapClient.Endpoints.createStudentLocation.url, completion: handleCreateStudentLocationResponse(response:error:))
        }
    }
    
    func handleCreateStudentLocationResponse(response: CreateStudentLocationResponse?, error: Error?) {
        showActivityIndicator(show: false)
        if error == nil {
            if let response = response {
                print( response)
            }
        }
    }
    
    func createStudentInformation() -> StudentInformation? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        let dateString = dateFormatter.string(from: Date())
        
        guard let coordinates = self.locationCoordinates else {
            return nil
        }
        let studentInformation = StudentInformation(createdAt: dateString,
                                                    firstName: OnTheMapClient.Auth.firstName,
                                                    lastName: OnTheMapClient.Auth.lastName,
                                                    latitude: coordinates.latitude,
                                                    longitude: coordinates.longitude,
                                                    mapString: self.locationTextField.text!,
                                                    mediaURL: self.urlTextField.text ?? "",
                                                    objectId: "",
                                                    uniqueKey: OnTheMapClient.Auth.key,
                                                    updatedAt: dateString)
        return studentInformation
    }
    
    @IBAction func findLocationButtonTapped(_ sender: Any) {
//        DispatchQueue.main.async {
//            self.showActivityIndicator(show: true)
//        }
        self.showActivityIndicator(show: true)
        guard let locationText = self.locationTextField.text else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText) { (placemarks, error) in
            if let placemark = placemarks?.first {
                if let locationCoordinates: CLLocationCoordinate2D = placemark.location?.coordinate {
                    self.locationCoordinates = locationCoordinates
                    print("Breite \(locationCoordinates.longitude) / Länge \(locationCoordinates.latitude)")
                    
                    
                    let coordinateRegion = MKCoordinateRegion(center: locationCoordinates, span: MKCoordinateSpan(latitudeDelta: 15.0, longitudeDelta: 15.0))
                    self.addLocationMapView.setRegion(coordinateRegion, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = locationCoordinates
                    annotation.title = OnTheMapClient.Auth.firstName + " " + OnTheMapClient.Auth.lastName
                    annotation.subtitle = self.urlTextField.text!
                    
                    self.addLocationMapView.addAnnotation(annotation)
                    self.displayMap(showing: true)
                }
            }
            
                        self.showActivityIndicator(show: false)
                    
        }

    }
    
    func displayMap(showing: Bool){
        if showing {
            self.addLocationMapView.isHidden = false
            self.finishButton.isHidden = false
            self.findLocationButton.isHidden = true
            self.locationTextField.isHidden = true
            self.urlTextField.isHidden = true
        } else {
            self.addLocationMapView.isHidden = true
            self.finishButton.isHidden = true
            self.findLocationButton.isHidden = false
            self.locationTextField.isHidden = false
            self.urlTextField.isHidden = false
        }
    }
    
    func showActivityIndicator(show: Bool) -> Void {
        if show {
            addLocationActivityIndicator.startAnimating()
        } else {
            addLocationActivityIndicator.stopAnimating()
        }
    }
}
