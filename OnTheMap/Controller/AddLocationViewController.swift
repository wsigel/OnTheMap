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
    var studentInformationMapViewDelegate: StudentInformationMapViewDelegate = StudentInformationMapViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLocationMapView.delegate = studentInformationMapViewDelegate
        displayMap(showing: false)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: create new location & post it
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        if let studentInformation = createStudentInformation() {
           showActivityIndicator(show: true)
            DispatchQueue.main.async {
                UdacityClient.createStudentLocation(studentInformation: studentInformation, url: UdacityClient.Endpoints.createStudentLocation.url, completion: self.handleCreateStudentLocationResponse(response:error:))
            }
        }
    }
    
    func handleCreateStudentLocationResponse(response: CreateStudentLocationResponse?, error: Error?) {
        showActivityIndicator(show: false)
        if error == nil {
            if response != nil {
                dismiss(animated: true, completion: nil)
            }
        } else {
            ErrorAlertController.showAlertController(parent: self, title: "Geocoding failure", message: "Error retrieving coordinates")
        }
    }
    
    // MARK: build a StudentInformation used for posting
    
    func createStudentInformation() -> StudentInformation? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        let dateString = dateFormatter.string(from: Date())
        
        guard let coordinates = self.locationCoordinates else {
            return nil
        }
        let studentInformation = StudentInformation(createdAt: dateString,
                                                    firstName: UdacityClient.Auth.firstName,
                                                    lastName: UdacityClient.Auth.lastName,
                                                    latitude: coordinates.latitude,
                                                    longitude: coordinates.longitude,
                                                    mapString: self.locationTextField.text!,
                                                    mediaURL: self.urlTextField.text ?? "",
                                                    objectId: "",
                                                    uniqueKey: UdacityClient.Auth.key,
                                                    updatedAt: dateString)
        return studentInformation
    }
    
    // MARK: try to forward geocode from location textfield
    
    @IBAction func findLocationButtonTapped(_ sender: Any) {
        self.showActivityIndicator(show: true)
        guard let locationText = self.locationTextField.text else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText, completionHandler: handleGeocodingAddressString(placemarks:error:))
    }
    
    func handleGeocodingAddressString(placemarks: [CLPlacemark]?, error: Error?) -> Void {
        self.showActivityIndicator(show: false)
        if error != nil {
            ErrorAlertController.showAlertController(parent: self, title: "Geocoding failure", message: "Unable to retrieve coordinates for given location")
        }
        guard let placemarks = placemarks else {
            return
        }
        if placemarks.count >= 1 {
            if let placemark = placemarks.first {
                if let locationCoordinates: CLLocationCoordinate2D = placemark.location?.coordinate {
                self.locationCoordinates = locationCoordinates
                let coordinateRegion = MKCoordinateRegion(center: locationCoordinates, span: MKCoordinateSpan(latitudeDelta: 15.0, longitudeDelta: 15.0))
                self.addLocationMapView.setRegion(coordinateRegion, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = locationCoordinates
                annotation.title = UdacityClient.Auth.firstName + " " + UdacityClient.Auth.lastName
                annotation.subtitle = self.urlTextField.text!
                self.addLocationMapView.addAnnotation(annotation)
                self.displayMap(showing: true)
                }
            }
        }
    }
    
    // MARK: hide input controls after successful geocoding & show map
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
